//
//  PKManagedObjectContext.m
//  PKToolbox
//
//  Created by Pavel Kunc on 04/09/2014.
//  Copyright (c) 2014 Pavel Kunc. All rights reserved.
//

#import "PKManagedObjectContext.h"

@implementation PKManagedObjectContext

//FIXME: We need to handle errors here somehow! (pavel, Tue 16 Sep 21:32:06 2014)
//FIXME: And what about the options for the store (pavel, Tue 16 Sep 21:32:20 2014)
+ (instancetype)createAtURL:(NSURL *)aURL
        withConcurrencyType:(NSManagedObjectContextConcurrencyType)aConcurrencyType {

    // Load & merge models
    NSMutableArray *models = [NSMutableArray array];
    NSURL *modelURL = [self managedObjectModelURL];
    NSAssert(modelURL != nil, @"Couldn't find model named '%@'", [modelURL path]);

    NSManagedObjectModel *model =
        [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(model != nil, @"Couldn't load model at '%@'", modelURL);
    [models addObject:model];

    NSManagedObjectModel *mergedModel = [NSManagedObjectModel modelByMergingModels:models];
    NSAssert(mergedModel != nil, @"Could not load MOM");

    // Create Persistent store coordinator
    NSPersistentStoreCoordinator *coordinator =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

    // Add Persistent stores
    NSError * __autoreleasing error = nil;
    NSString *storeType = aURL == nil ? NSInMemoryStoreType : NSSQLiteStoreType;

    // Define the Core Data version migration options
    NSDictionary *options = @{};
    /*
    NSDictionary *options = @{
        NSMigratePersistentStoresAutomaticallyOption: @YES,
        NSInferMappingModelAutomaticallyOption: @YES
        //NSPersistentStoreFileProtectionKey: NSFileProtectionComplete
    };
    */

    if (![coordinator addPersistentStoreWithType:storeType
                                   configuration:nil
                                             URL:aURL
                                         options:options
                                           error:&error]) {
        if ([error code] == NSMigrationMissingSourceModelError) {
            NSLog(@"Migration failed. Try deleting %@", aURL);
        }
        else {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        NSAssert(nil, @"Unable to create context!");
    }

    PKManagedObjectContext *context =
        [[self alloc] initWithConcurrencyType:aConcurrencyType];
    [context setPersistentStoreCoordinator:coordinator];

    return context;
}


#pragma mark - Master/Writer approach (separate contexts)

+ (instancetype)createMaster {
    return [self createAtURL:[self persistentStoreURL]
         withConcurrencyType:NSMainQueueConcurrencyType];
}

+ (instancetype)createWorker {
    return [self createAtURL:[self persistentStoreURL]
         withConcurrencyType:NSPrivateQueueConcurrencyType];
}


#pragma mark - For testing

+ (instancetype)createInMemory {
    return [self createAtURL:nil withConcurrencyType:NSMainQueueConcurrencyType];
}


#pragma mark - Utility methods

+ (NSURL *)managedObjectModelURL {
    NSString *modelName = [self managedObjectModelName];
    NSAssert(modelName != nil, @"%@ must implement +managedObjectModelName", NSStringFromClass(self));

    NSBundle *bundle = [NSBundle bundleForClass:self];
    return [bundle URLForResource:modelName withExtension:@"momd"];
}

+ (NSString *)managedObjectModelName {
    return nil;
}

+ (NSString *)persistentStoreFileName {
    return [[self managedObjectModelName] stringByAppendingPathExtension:@"sqlite"];
}

+ (NSURL *)persistentStoreDirectoryURL {
    return nil;
}

+ (NSURL *)persistentStoreURL {
    NSURL *directoryURL = [self persistentStoreDirectoryURL];
    NSAssert(directoryURL != nil,
             @"%@ must implement +persistentStoreDirectoryURL",
             NSStringFromClass(self));

    return [directoryURL URLByAppendingPathComponent:[self persistentStoreFileName]];
}

@end

