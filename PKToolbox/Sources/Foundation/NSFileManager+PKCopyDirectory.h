//
//  NSFileManager+PKCopyDirectory.h
//  PKToolbox
//
//  Created by Pavel Kunc on 20/10/2011.
//  Copyright 2011 Pavel Kunc. All rights reserved.
//

@interface NSFileManager (PKCopyDirectory)

/**
 * Copy directory to dstDirectoryPath with possible overwrite/merge
 *
 * This method copy directory at srcDirectoryPath to dstDirectoryPath and
 * overwrite files whch exists at dstDirectoryPath if overwrite flag is YES.
 *
 * If overwrite is set and FILE (not directory) at the destination exists it is
 * first removed and then copied to the propper location.
 *
 * Resulting directory/file structure is effectively merge between SRC and DST
 * structures with all files updated to the SRC content.
 *
 * @param srcDirectoryPath Path to directory which is to copy
 * @param dstDirectoryPath Destination which MAY exist
 * @returns YES if all went well otherwise NO and sets outError
 */
- (BOOL)pk_copyDirectoryAtPath:(NSString *)srcDirectoryPath
                        toPath:(NSString *)dstDirectoryPath
                     overwrite:(BOOL)overwrite
                         error:(NSError **)outError;

@end

