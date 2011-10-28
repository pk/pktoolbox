//
//  NSFileManager+PKCopyDirectoryTest.m
//  PKToolbox
//
//  Created by Pavel Kunc on 27/10/2011.
//  Copyright 2011 Pavel Kunc. All rights reserved.
//

#import "NSFileManager+PKCopyDirectory.h"

@interface NSFileManagerPKCopyDirectoryTest : SenTestCase {}
- (NSString *)absolutePathForFixtureAtPath:(NSString *)aPath;
@end


@implementation NSFileManagerPKCopyDirectoryTest

- (NSString *)absolutePathForFixtureAtPath:(NSString *)aPath {
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSArray *components = [[NSArray alloc] initWithObjects:[fm currentDirectoryPath],
                                                           @"/PKToolboxTests/Fixtures/",
                                                           aPath,
                                                           nil];
    NSString *path = [NSString pathWithComponents:components];
    [components release];
    [fm release];
    return path;
}

#pragma mark - pk_copyDirectoryAtPath:toPath:overwrite:error:

- (void)testCopyDirectoryAtPathCopyAndOverrideAllContentWithSourcePathContent {
    NSString *originalPath = [self absolutePathForFixtureAtPath:@"to-copy-original"];
    NSString *updatedPath = [self absolutePathForFixtureAtPath:@"to-copy-updated"];
    NSString *resultPath = [self absolutePathForFixtureAtPath:@"to-copy-result"];

    NSError *error;
    NSFileManager *fm = [[NSFileManager alloc] init];
    if ([fm fileExistsAtPath:resultPath]) {
        if (![fm removeItemAtPath:resultPath error:&error]) {
            STFail(@"Can't remove results directory due to: %@!", [error localizedDescription]);
        }
    }
    if (![fm copyItemAtPath:originalPath toPath:resultPath error:&error]) {
        STFail(@"Can't prepare results directory due to: %@!", [error localizedDescription]);
    }

    BOOL done = [fm pk_copyDirectoryAtPath:updatedPath
                                       toPath:resultPath
                                    overwrite:YES
                                       error:&error];
    assertThatBool(done, equalToBool(YES));

    NSArray *currentContent = [fm contentsOfDirectoryAtPath:resultPath error:&error];
    assertThat(currentContent, hasItems(equalTo(@"A"),equalTo(@"B"),equalTo(@"C"),nil));

    NSString *originalFilePath = [self absolutePathForFixtureAtPath:@"to-copy-original/A/AA.txt"];
    NSString *resultFilePath = [self absolutePathForFixtureAtPath:@"to-copy-result/A/AA.txt"];
    NSString *originalContent = [NSString stringWithContentsOfFile:originalFilePath
                                                          encoding:NSUTF8StringEncoding
                                                             error:NULL];
    NSString *resultContent = [NSString stringWithContentsOfFile:resultFilePath
                                                        encoding:NSUTF8StringEncoding
                                                           error:NULL];
    assertThat(resultContent, isNot(equalTo(originalContent)));
    assertThat(resultContent, containsString(@"AA-updated"));
}

@end

