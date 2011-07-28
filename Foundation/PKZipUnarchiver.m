//
//  PKZipUnarchiver.m
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz

#import "PKZipUnarchiver.h"
#import "ZipFile.h"
#import "ZipFileInfo.h"
#import "ZipReadStream.h"


@interface PKZipUnarchiver ()
@property (nonatomic, retain, readonly) ZipFile *zipFile;

- (NSArray *)zipFilesInformation;
@end


@implementation PKZipUnarchiver

@synthesize delegate = _delegate;
@synthesize zipPath  = _zipPath;
@synthesize zipFile  = _zipFile;


#pragma mark - Initialization/dealloc

- (void)dealloc {
    [_zipFile release];
    [_zipPath release];
    [_zipFilesInformation release];
    [super dealloc];
}

- (id)initWithZipAtPath:(NSString *)aPath delegate:(id<PKZipUnarchiverDelegate>)aDelegate {
    NSParameterAssert(aPath);

    self = [super init];
    if (self != nil) {
        _delegate = aDelegate;
        _zipPath  = [aPath copy];
        _zipFile  = [[ZipFile alloc] initWithFileName:_zipPath mode:ZipFileModeUnzip];
    }
    return self;
}

- (id)initWithZipAtPath:(NSString *)aPath {
    return [self initWithZipAtPath:aPath delegate:nil];
}


#pragma mark - Unzip methods

- (BOOL)unzipTo:(NSString *)aDestination error:(NSError **)outError {
    if (![self.zipFile goToFirstFileInZip:outError]) {
        return NO;
    }

    BOOL isDirectory;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *currentFilePath;
    NSUInteger currentFileIndex = 0;
    NSArray *zipFilesInfo = [self zipFilesInformation];
    do {
        ZipReadStream *file = [self.zipFile readCurrentFileInZip:outError];
        ZipFileInfo *fileInfo = [zipFilesInfo objectAtIndex:currentFileIndex];
        isDirectory = [fileInfo.name hasSuffix:@"/"];
        currentFilePath = [aDestination stringByAppendingPathComponent:fileInfo.name];

        if (isDirectory) {
            [fileManager createDirectoryAtPath:currentFilePath
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:outError];
        } else {
            [fileManager createFileAtPath:currentFilePath
                                 contents:nil
                               attributes:nil];

            NSUInteger bytesRead = 0;
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:currentFilePath];
            NSMutableData *buffer = [[NSMutableData alloc] initWithLength:PK_ZIPUNARCHIVER_BUFFER_SIZE];
            while ((bytesRead = [file readDataWithBuffer:buffer error:outError]) != 0) {
                [fileHandle writeData:buffer];
                if ([self.delegate respondsToSelector:@selector(didUncompressBytes:total:)]) {
                    [self.delegate didUncompressBytes:bytesRead total:[self uncompressedSize]];
                }
            }
            [buffer release]; buffer = nil;
            [fileHandle closeFile];
        }
        [file finishedReadingWithError:outError];
        currentFileIndex++;
    } while([self.zipFile goToNextFileInZip:outError]);

    [fileManager release];
    [self.zipFile close];

    return YES;
}

- (NSUInteger)uncompressedSize {
    if (_uncompressedSize != 0) {
        return _uncompressedSize;
    }
    ZipFileInfo *fileInfo;
    NSArray *zipFilesInfo = [self zipFilesInformation];
    for (fileInfo in zipFilesInfo) {
        _uncompressedSize += fileInfo.length;
    }
    return _uncompressedSize;
}


#pragma mark - Private methods

- (NSArray *)zipFilesInformation {
    if (_zipFilesInformation != nil) {
        return _zipFilesInformation;
    }
    _zipFilesInformation = [[self.zipFile containedFiles] retain];
    return _zipFilesInformation;
}

@end

