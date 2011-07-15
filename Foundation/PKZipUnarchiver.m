//
//  PKZipUnarchiver.m
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz


#import "PKZipUnarchiver.h"

@interface PKZipUnarchiver ()
@property (nonatomic, copy, readonly)   NSString   *zipPath;
@end


@implementation PKZipUnarchiver

@synthesize delegate              = _delegate;
@synthesize zipPath               = _zipPath;


#pragma mark - Initialization/dealloc

- (void)dealloc {
    [_zipPath release];
    [super dealloc];
}

- (id)initWithZipAtPath:(NSString *)aPath delegate:(id<PKZipUnarchiverDelegate>)aDelegate {
    if (self != nil) {
        _zipPath = [aPath copy];
        _delegate = aDelegate;
    }
    return self;
}

- (id)initWithZipAtPath:(NSString *)aPath {
    return [self initWithZipAtPath:aPath delegate:nil];
}


#pragma mark - Unzip methods

- (BOOL)unzipTo:(NSString *)aDestination error:(NSError **)outError {
    ZipFile *zipFile = [[ZipFile alloc] initWithFileName:_zipPath mode:ZipFileModeUnzip];

    NSUInteger totalUncompressedSize = 0;
    NSArray *zipFileInformation = [zipFile containedFiles];
    if ([self.delegate respondsToSelector:@selector(didUncompressBytes:total:)]) {
        ZipFileInfo *fileInfo;
        for (fileInfo in zipFileInformation) {
            totalUncompressedSize += fileInfo.length;
            LogDebug(@"File:%@ of size %d",fileInfo.name,fileInfo.length);
        }
    }
    
    if (![zipFile goToFirstFileInZip:outError]) {
        return NO;
    }
    
    BOOL isDirectory;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *currentFilePath;
    NSUInteger currentFileIndex = 0;
    do {
        ZipReadStream *file = [zipFile readCurrentFileInZip:outError];
        ZipFileInfo *fileInfo = [zipFileInformation objectAtIndex:currentFileIndex];
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
                    [self.delegate didUncompressBytes:bytesRead total:totalUncompressedSize];
                }
            }
            [buffer release]; buffer = nil;
            [fileHandle closeFile];
        }
        [file finishedReadingWithError:outError];
        currentFileIndex++;
    } while([zipFile goToNextFileInZip:outError]);

    [fileManager release];
    [zipFile close];
    [zipFile release];

    return YES;
}

@end

