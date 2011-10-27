//
//  PKZipUnarchiver.h
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz

#import <Foundation/Foundation.h>

#ifndef PK_ZIPUNARCHIVER_BUFFER_SIZE
#define PK_ZIPUNARCHIVER_BUFFER_SIZE (1024 * 32)
#endif

@protocol PKZipUnarchiverDelegate <NSObject>
@optional
-(void)didStartUncompressingZip;
-(void)didUncompressBytes:(NSUInteger)bytes total:(NSUInteger)total;
-(void)didFinishUncompressingZip;
@end


@class ZipFile;

@interface PKZipUnarchiver : NSObject {
@private
    NSString                    *_zipPath;
    id<PKZipUnarchiverDelegate>  _delegate;

    ZipFile                     *_zipFile;
    NSArray                     *_zipFilesInformation;
    NSUInteger                  _uncompressedSize;
}

@property (nonatomic, assign, readwrite) id<PKZipUnarchiverDelegate> delegate;
@property (nonatomic, copy,   readonly)  NSString *zipPath;

- (id)initWithZipAtPath:(NSString *)aPath;
- (id)initWithZipAtPath:(NSString *)aPath delegate:(id<PKZipUnarchiverDelegate>)aDelegate;
- (BOOL)unzipTo:(NSString *)aDestination error:(NSError **)outError;

- (NSUInteger)uncompressedSize;

@end

