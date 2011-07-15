//
//  PKZipUnarchiver.h
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz

#import <Foundation/Foundation.h>

#import "ZipFile.h"
#import "ZipFileInfo.h"
#import "ZipReadStream.h"


#ifndef PK_ZIPUNARCHIVER_BUFFER_SIZE
#define PK_ZIPUNARCHIVER_BUFFER_SIZE (1024 * 32)
#endif

@protocol PKZipUnarchiverDelegate <NSObject>
@optional
-(void)didStartUncompressingZip;
-(void)didUncompressBytes:(NSUInteger)bytes total:(NSUInteger)total;
-(void)didFinishUncompressingZip;
@end


@interface PKZipUnarchiver : NSObject {
@private
    NSString                    *_zipPath;
    id<PKZipUnarchiverDelegate>  _delegate;
}

@property (nonatomic, assign, readwrite) id<PKZipUnarchiverDelegate> delegate;

- (id)initWithZipAtPath:(NSString *)aPath;
- (id)initWithZipAtPath:(NSString *)aPath delegate:(id<PKZipUnarchiverDelegate>)aDelegate;
- (BOOL)unzipTo:(NSString *)aDestination error:(NSError **)outError;

@end

