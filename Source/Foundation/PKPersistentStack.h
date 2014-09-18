//
//  PKPersistentStack.h
//  PKToolbox
//
//  Created by Pavel Kunc on 10/10/2012.
//  Copyright (c) 2012 Fry-it, Limited. All rights reserved.
//

@import Foundation.NSString;
@import Foundation.NSArray;
@import Foundation.NSError;
@import Foundation.NSException;
@import Foundation.NSFileManager;
@import Foundation.NSKeyedArchiver;
@import Foundation.NSKeyValueCoding;

// Error domain
extern NSString * const PKPersistentStackErrorDomain;

// Error codes
typedef NS_ENUM(NSInteger, PKPersistentStackError) {
    PKPersistentStackErrorInvalidArchiveFile = 1,
    PKPersistentStackErrorArchiveFileNotExists = 2,
    PKPersistentStackErrorNoPathProvided = 3
};

@interface PKPersistentStack : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *objects;

#pragma mark - Initialization

- (instancetype)initWithPath:(NSString *)path;


#pragma mark - Persistence

- (BOOL)loadWithError:(NSError * __autoreleasing *)outError;
- (BOOL)saveWithError:(NSError * __autoreleasing *)outError;


#pragma mark - NSArray & NSMutableArray interface

- (NSUInteger)count;
- (NSUInteger)indexOfObject:(id)anObject;
- (id)objectAtIndex:(NSUInteger)index;

- (void)addObject:(id)anObject;
- (void)addObjectsFromArray:(NSArray *)otherArray;

- (void)removeAllObjects;
- (void)removeObject:(id)anObject;
- (void)removeObjectAtIndex:(NSUInteger)index;

@end

