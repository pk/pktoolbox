//
//  PKPersistentStackSpec.m
//  PKToolbox
//
//  Created by Pavel Kunc on 24/06/2014.
//

#define EXP_SHORTHAND
#import "Expecta.h"
#import "Specta.h"
#import "OCMock.h"

#import "PKPersistentStack.h"

@interface PKPersistentStackSpecsHelpers : NSObject
+ (PKPersistentStack *)persistentStackWithObjects:(NSArray *)objects
                                           atPath:(NSString *)path
                                            error:(NSError * __autoreleasing *)outError;
@end

@implementation PKPersistentStackSpecsHelpers

+ (PKPersistentStack *)persistentStackWithObjects:(NSArray *)aObjects
                                           atPath:(NSString *)aPath
                                            error:(NSError * __autoreleasing *)outError {
    PKPersistentStack *stack = [[PKPersistentStack alloc] initWithPath:aPath];
    [stack addObjectsFromArray:aObjects];
    BOOL success = [stack saveWithError:outError];
    return success ? stack : nil;
}

+ (NSString *)temporaryStackFile {
    NSString *tempPath = NSTemporaryDirectory();
    NSString *fileName =
        [[[NSProcessInfo processInfo] globallyUniqueString] stringByAppendingPathExtension:@"stack"];
    return [[NSURL fileURLWithPath:[tempPath stringByAppendingPathComponent:fileName]] path];
}

@end


SpecBegin(PKPersistentStackSpecs)

describe(@"PKPersistentStack", ^{
    __block NSString *_filePath = nil;
    __block PKPersistentStack *_stack = nil;

    beforeEach(^{
        _filePath = [PKPersistentStackSpecsHelpers temporaryStackFile];

        NSError * __autoreleasing error = nil;
        _stack = [PKPersistentStackSpecsHelpers persistentStackWithObjects:@[@"a", @"b"]
                                                                    atPath:_filePath
                                                                     error:&error];
    });

    afterEach(^{
        [[NSFileManager new] removeItemAtPath:_filePath error:NULL];
        _filePath = nil;
        _stack = nil;
    });

    context(@"NSMutableArray interface", ^{

        NSArray *selectors = @[
            [NSValue valueWithPointer:@selector(count)],
            [NSValue valueWithPointer:@selector(indexOfObject:)],
            [NSValue valueWithPointer:@selector(objectAtIndex:)],
            [NSValue valueWithPointer:@selector(addObject:)],
            [NSValue valueWithPointer:@selector(addObjectsFromArray:)],
            [NSValue valueWithPointer:@selector(removeAllObjects)],
            [NSValue valueWithPointer:@selector(removeObject:)],
            [NSValue valueWithPointer:@selector(removeObjectAtIndex:)]
        ];
        for (NSValue *value in selectors) {
            PKPersistentStack *stack = [PKPersistentStack new];

            SEL selector = nil;
            [value getValue:&selector];

            NSString *format = @"should provide NSMutableArray like interface responding to %@";
            NSString *description = [NSString stringWithFormat:format, NSStringFromSelector(selector)];
            it(description, ^{
                expect(stack).respondTo(selector);
            });
        }

        context(@"-count", ^{
            it(@"should return number of elements in the stack", ^{
                expect(_stack).haveCountOf(2);
            });
        });

        context(@"-indexOfObject:", ^{
            it(@"should return index of object", ^{
                expect([_stack indexOfObject:@"b"]).equal(1);
            });
         });

        context(@"-objectAtIndex:", ^{
            it(@"should return object at specified index", ^{
                expect([_stack objectAtIndex:0]).equal(@"a");
            });
         });

        context(@"-addObject:", ^{
            it(@"should add object to the stack", ^{
                expect(_stack).haveCountOf(2);
                [_stack addObject:@"c"];
                expect(_stack).haveCountOf(3);
            });
        });

        context(@"-addObjectsFromArray:", ^{
            it(@"should add all objects from the array to stack", ^{
                expect(_stack).haveCountOf(2);
                [_stack addObjectsFromArray:@[@"c", @"d"]];
                expect(_stack).haveCountOf(4);

            });
         });

        context(@"-removeAllObjects", ^{
            it(@"sould remove all objects from stack", ^{
                expect(_stack).haveCountOf(2);
                [_stack removeAllObjects];
                expect(_stack).beEmpty();
            });
         });

        context(@"-removeObject:", ^{
            it(@"should be able remove an item", ^{
                expect(_stack).haveCountOf(2);
                [_stack removeObject:@"a"];
                expect(_stack).haveCountOf(1);
            });
        });

        context(@"-removeObjectAtIndex:", ^{
            it(@"should remove object at passed index", ^{
                expect(_stack).haveCountOf(2);
                [_stack removeObjectAtIndex:0];
                expect(_stack).haveCountOf(1);
            });
         });

    });

    context(@"when initialized with path", ^{
        __block PKPersistentStack *_stack = nil;

        beforeEach(^{
            _stack = [[PKPersistentStack alloc] initWithPath:_filePath];
        });

        afterEach(^{
            _stack = nil;
        });

        it(@"should be empty", ^{
            expect([[PKPersistentStack alloc] initWithPath:_filePath]).beEmpty();
        });

        for (NSArray *items in @[@[], @[@"a"], @[@"a", @"b"]]) {
            NSString *format = @"should be able to save stack with %d items";
            NSString *description = [NSString stringWithFormat:format, [items count]];
            it(description, ^{
                NSError * __autoreleasing error = nil;
                PKPersistentStack *stack =
                    [PKPersistentStackSpecsHelpers persistentStackWithObjects:items
                                                                       atPath:_filePath
                                                                        error:&error];
                expect(stack).notTo.beNil();

                NSError * __strong err = error;
                expect(err).beNil();

                // Make sure we actually created some file
                expect([[NSFileManager new] fileExistsAtPath:_filePath]).beTruthy();
            });
        }

        for (NSArray *items in @[@[], @[@"a"], @[@"a", @"b"]]) {
            NSString *format = @"should be able to load stack with %d items";
            NSString *description = [NSString stringWithFormat:format, [items count]];
            it(description, ^{
                NSError * __autoreleasing error = nil;
                PKPersistentStack *stack =
                    [PKPersistentStackSpecsHelpers persistentStackWithObjects:items
                                                                       atPath:_filePath
                                                                        error:&error];

                stack = [[PKPersistentStack alloc] initWithPath:_filePath];
                BOOL success = [stack loadWithError:&error];
                expect(success).beTruthy();
                expect(stack).haveCountOf([items count]);

                NSError * __strong err = error;
                expect(err).beNil();
            });
        }

        it(@"should save empty stack when all objects has been removed", ^{
            NSString *object = @"test";

            // Create stack with one object and save it
            NSError * __autoreleasing error = nil;
            PKPersistentStack *stack =
                [PKPersistentStackSpecsHelpers persistentStackWithObjects:@[object]
                                                                   atPath:_filePath
                                                                    error:&error];

            // Load the file created by the ^ and test we have the same content
            BOOL success = [_stack loadWithError:&error];
            expect(success).beTruthy();
            expect(_stack).haveCountOf(1);
            expect([_stack objectAtIndex:0]).equal(object);

            [_stack removeObject:object];
            expect(_stack).beEmpty();
            success = [_stack saveWithError:&error];
            expect(success).beTruthy();

            stack = [[PKPersistentStack alloc] initWithPath:_filePath];
            [stack loadWithError:NULL];
            expect(stack).beEmpty();
        });

        it(@"should not load stack and return PKPersistentStackErrorArchiveFileNotExists error if file doesn't exist", ^{
            NSError * __autoreleasing error = nil;
            PKPersistentStack *stack = [[PKPersistentStack alloc] initWithPath:@"wrong"];
            BOOL success = [stack loadWithError:&error];
            expect(success).beFalsy();

            NSError * __strong err = error;
            expect(err).notTo.beNil();
            expect(err.domain).equal(PKPersistentStackErrorDomain);
            expect(err.code).equal(@(PKPersistentStackErrorArchiveFileNotExists));
        });

        it(@"should not load stack and return PKPersistentStackErrorInvalidArchiveFile error if file is corrupted", ^{
            NSError * __autoreleasing error = nil;

            // Create strange file
            BOOL success = [@"foobar" writeToFile:_filePath
                                       atomically:YES
                                         encoding:NSUTF8StringEncoding
                                            error:&error];
            expect(success).beTruthy;
            success = [_stack loadWithError:&error];
            expect(success).beFalsy;

            NSError * __strong err = error;
            expect(err).notTo.beNil();
            expect(err.domain).equal(PKPersistentStackErrorDomain);
            expect(err.code).equal(@(PKPersistentStackErrorInvalidArchiveFile));
        });
    });

    context(@"when initialized without path", ^{
        __block PKPersistentStack *_stack;

        beforeEach(^{
            _stack = [PKPersistentStack new];
        });

        afterEach(^{
            _stack = nil;
        });

        it(@"should be empty", ^{
            expect(_stack).beEmpty();
        });

        it(@"should not load stack and return PKPersistentStackErrorArchiveFileNotExists error", ^{
            NSError * __autoreleasing error = nil;
            BOOL success = [_stack loadWithError:&error];
            expect(success).beFalsy();

            NSError * __strong err = error;
            expect(err).notTo.beNil();
            expect(err.domain).equal(PKPersistentStackErrorDomain);
            expect(err.code).equal(@(PKPersistentStackErrorArchiveFileNotExists));
        });

        it(@"should not save stack and return PKPersistentStackErrorNoPathProvided error", ^{
            NSError * __autoreleasing error = nil;
            BOOL success = [_stack saveWithError:&error];
            expect(success).beFalsy();

            NSError * __strong err = error;
            expect(err).notTo.beNil();
            expect(err.domain).equal(PKPersistentStackErrorDomain);
            expect(err.code).equal(@(PKPersistentStackErrorNoPathProvided));
        });

    });

});

SpecEnd
