//
//  NSFileManager+PKCopyDirectory.m
//  PKToolbox
//
//  Created by Pavel Kunc on 20/10/2011.
//  Copyright 2011 Pavel Kunc. All rights reserved.
//

#import "NSFileManager+PKCopyDirectory.h"

@implementation NSFileManager (PKCopyDirectory)

- (BOOL)pk_copyDirectoryAtPath:(NSString *)srcDirectoryPath
                        toPath:(NSString *)dstDirectoryPath
                     overwrite:(BOOL)overwrite
                         error:(NSError **)outError {
    BOOL didCopy = NO;
    BOOL success = YES;

    NSFileManager *fm = [[NSFileManager alloc] init];
    // Don't ever use enumeratorAtURL:includingPropertiesForKeys:options:errorHandler:
    // it doesn't work on iOS 4.x! http://openradar.appspot.com/9536091
    NSDirectoryEnumerator *enumerator = [fm enumeratorAtPath:srcDirectoryPath];

    // Outer loop is neccessary to release srcFile because enumerator somehow
    // release all after ALL iterations. So we force release using inner pool.
    while(YES) {
        @autoreleasepool {
            NSString *srcFile = [enumerator nextObject];
            if (srcFile == nil) break;
            didCopy = YES;

            NSString *srcFilePath = [srcDirectoryPath stringByAppendingPathComponent:srcFile];
            NSString *dstFilePath = [dstDirectoryPath stringByAppendingPathComponent:srcFile];

            NSDictionary *srcFileAtributes = [enumerator fileAttributes];
            NSDictionary *dstFileAtributes = [fm attributesOfItemAtPath:dstFilePath
                                                                  error:outError];
            BOOL srcFileIsDirectory = ([srcFileAtributes fileType] == NSFileTypeDirectory);
            BOOL dstFileIsDirectory = ([dstFileAtributes fileType] == NSFileTypeDirectory);
            BOOL dstFileExists = (dstFileAtributes != nil);

            ////////////////////////
            // Handle directories //
            ////////////////////////

            if (srcFileIsDirectory && dstFileExists) continue;
            if (srcFileIsDirectory && !dstFileExists) {
                if (![fm createDirectoryAtPath:dstFilePath
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:outError]) {
                    success = NO;
                    break;
                }
                continue;
            }

            //////////////////
            // Handle files //
            //////////////////

            // Remove file if it exists
            if (dstFileExists) {
                if (![fm removeItemAtPath:dstFilePath error:outError]) {
                    success = NO;
                    break;
                }
            }

            // Copy new file into the destination
            if (![fm copyItemAtPath:srcFilePath toPath:dstFilePath error:outError]) {
                success = NO;
                break;
            }
        } // autoreleasepool
    } // while
    [fm release];

    return didCopy && success;
}

@end

