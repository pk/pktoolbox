//
//  PKPersistentStack.m
//  PKToolbox
//
//  Created by Pavel Kunc on 10/10/2012.
//  Copyright (c) 2012 Fry-it, Limited. All rights reserved.
//

#import "PKPersistentStack.h"

NSString * const PKPersistentStackErrorDomain =
    @"cz.pavelkunc.pktoolbox.persistentStack";

@interface PKPersistentStack()
@property (nonatomic, copy, readwrite) NSString *path;
@end


@implementation PKPersistentStack {
    NSMutableArray * __strong _objects;
}


#pragma mark - Init

- (instancetype)initWithPath:(NSString *)aPath {
    self = [super init];
    if (!self) return nil;

    self->_path = [aPath copy];
    self->_objects = [[NSMutableArray alloc] initWithCapacity:20];

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Persistent stack at path: %@\nContent: %@",
                                      self.path,
                                      self->_objects];
}


#pragma mark - Persistence

- (BOOL)loadWithError:(NSError * __autoreleasing *)outError {
    NSAssert([self->_objects count] == 0,
             @"Stack is not empty! You should only load stack once!");

    @try {
        if (![[NSFileManager defaultManager] fileExistsAtPath:self.path]) {
            if (outError != NULL) {
                *outError = [NSError errorWithDomain:PKPersistentStackErrorDomain
                                                code:PKPersistentStackErrorArchiveFileNotExists
                                            userInfo:nil];
            }
            return NO;
        }

        NSMutableArray *stack = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
        if (stack == nil) return NO;

        [self->_objects addObjectsFromArray:stack];
        return YES;
    }
    @catch (NSException *e) {
        if (outError != NULL) {
            *outError = [NSError errorWithDomain:PKPersistentStackErrorDomain
                                            code:PKPersistentStackErrorInvalidArchiveFile
                                        userInfo:nil];
        }
        return NO;
    }
}

- (BOOL)saveWithError:(NSError * __autoreleasing *)outError {
    // Check if we can actually save
    if (self.path == nil) {
        *outError = [NSError errorWithDomain:PKPersistentStackErrorDomain
                                        code:PKPersistentStackErrorNoPathProvided
                                    userInfo:nil];
        return NO;
    }

    // Remove old stack file
    NSFileManager *fm = [NSFileManager new];
    if ([fm fileExistsAtPath:self.path]) {
        BOOL success = [fm removeItemAtPath:self.path error:outError];
        if (!success) return NO;
    }

    // Save objects we have and create new stack file
    return [NSKeyedArchiver archiveRootObject:self->_objects toFile:self.path];
}


#pragma mark - NSMutableArray interface

- (NSMutableArray *)objects {
    NSString *keyPath = NSStringFromSelector(@selector(objects));
    return [self mutableArrayValueForKey:keyPath];
}

- (NSUInteger)count {
    return [self.objects count];
}

- (NSUInteger)indexOfObject:(id)anObject {
    return [[self objects] indexOfObject:anObject];
}

- (id)objectAtIndex:(NSUInteger)index {
    return [[self objects] objectAtIndex:index];
}

- (void)addObject:(id)anObject {
    [[self objects] addObject:anObject];
}

- (void)addObjectsFromArray:(NSArray *)otherArray {
    [[self objects] addObjectsFromArray:otherArray];
}

- (void)removeAllObjects {
    NSUInteger count = [self count];
    for (NSUInteger index = 0; index < count; index++) {
        [self removeObjectAtIndex:0];
    }
}

- (void)removeObject:(id)anObject {
    [[self objects] removeObject:anObject];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [[self objects] removeObjectAtIndex:index];
}

@end

