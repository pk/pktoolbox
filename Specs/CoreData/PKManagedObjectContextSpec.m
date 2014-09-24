//
//  PKManagedObjectContextSpec.m
//  PKToolbox
//
//  Created by Pavel Kunc on 23/04/2014.
//

@import CoreData.NSPersistentStore;

#define EXP_SHORTHAND
#import "Expecta.h"
#import "Specta.h"
#import "PKManagedObjectContext.h"

@interface PKTestManagedObjectContext : PKManagedObjectContext
@end

@implementation PKTestManagedObjectContext

+ (NSString *)managedObjectModelName {
    return @"PKToolboxTest";
}

+ (NSURL *)persistentStoreDirectoryURL {
    return [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
}

@end

SpecBegin(PKManagedObjectContextSpec)

describe(@"PKManagedObjectContextSpec", ^{

    describe(@"createAtURL:withConcurencyType:", ^{

        it(@"should create context with PSC at provided URL", ^{
            NSURL *storeURL = [PKTestManagedObjectContext persistentStoreURL];

            PKTestManagedObjectContext *context =
                [PKTestManagedObjectContext createAtURL:storeURL
                                    withConcurrencyType:NSMainQueueConcurrencyType];

            expect(context.concurrencyType).equal(NSMainQueueConcurrencyType);

            NSPersistentStore *ps = [context.persistentStoreCoordinator.persistentStores lastObject];
            expect(ps).notTo.beNil();
            expect(ps.type).equal(NSSQLiteStoreType);

            BOOL removed = [[NSFileManager defaultManager] removeItemAtURL:storeURL error:NULL];
            expect(removed).beTruthy();
        });

        it(@"should create in memory context when URL is nil", ^{
            PKTestManagedObjectContext *context =
                [PKTestManagedObjectContext createAtURL:nil
                                    withConcurrencyType:NSPrivateQueueConcurrencyType];

            expect(context.concurrencyType).equal(NSPrivateQueueConcurrencyType);

            NSPersistentStore *ps = [context.persistentStoreCoordinator.persistentStores lastObject];
            expect(ps).notTo.beNil();
            expect(ps.type).equal(NSInMemoryStoreType);
        });

    });

    describe(@"createMaster", ^{
        it(@"should create context with SQL PSC on MainQueue", ^{
            PKTestManagedObjectContext *context = [PKTestManagedObjectContext createMaster];
            expect(context.concurrencyType).equal(NSMainQueueConcurrencyType);

            NSPersistentStore *ps =
                [context.persistentStoreCoordinator.persistentStores lastObject];
            expect(ps).notTo.beNil();
            expect(ps.type).equal(NSSQLiteStoreType);
        });
    });

    describe(@"createWorker", ^{
        it(@"should create context with SQL PSC on Private queue", ^{
            PKTestManagedObjectContext *context = [PKTestManagedObjectContext createWorker];
            expect(context.concurrencyType).equal(NSPrivateQueueConcurrencyType);

            NSPersistentStore *ps =
                [context.persistentStoreCoordinator.persistentStores lastObject];
            expect(ps).notTo.beNil();
            expect(ps.type).equal(NSSQLiteStoreType);
        });
    });

    describe(@"createInMemory", ^{
        it(@"should create context with in memory PSC on MainQueue", ^{
            PKTestManagedObjectContext *context = [PKTestManagedObjectContext createInMemory];
            expect(context.concurrencyType).equal(NSMainQueueConcurrencyType);

            NSPersistentStore *ps =
            [context.persistentStoreCoordinator.persistentStores lastObject];
            expect(ps).notTo.beNil();
            expect(ps.type).equal(NSInMemoryStoreType);
        });
    });

    describe(@"persistentStoreURL", ^{

        it(@"should return full URL for persistent store combining directory and filename", ^{
            NSString *path = [[PKTestManagedObjectContext persistentStoreURL] path];
            NSString *directory =
                [[PKTestManagedObjectContext persistentStoreDirectoryURL] path];
            expect(path).beginWith(directory);
            expect(path).endWith([PKTestManagedObjectContext persistentStoreFileName]);
        });

    });

    describe(@"persistentStoreFileName", ^{

        it(@"should return filename based on the model name", ^{
            NSString *fileName = [PKTestManagedObjectContext persistentStoreFileName];
            expect(fileName).beginWith([PKTestManagedObjectContext managedObjectModelName]);
        });

        it(@"should return filename with .sqlite extension", ^{
            NSString *fileName = [PKTestManagedObjectContext persistentStoreFileName];
            expect(fileName).endWith(@".sqlite");
        });

    });

});

SpecEnd
