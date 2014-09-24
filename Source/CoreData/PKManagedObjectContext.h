//
//  PKManagedObjectContext.h
//  PKToolbox
//
//  Created by Pavel Kunc on 04/09/2014.
//  Copyright (c) 2014 Pavel Kunc. All rights reserved.
//

@import Foundation.NSURL;
@import Foundation.NSError;
@import Foundation.NSException;
@import Foundation.NSString;
@import Foundation.NSPathUtilities;
@import Foundation.NSBundle;

@import CoreData.NSManagedObjectContext;
@import CoreData.NSManagedObjectModel;
@import CoreData.NSPersistentStoreCoordinator;
@import CoreData.CoreDataErrors;

@interface PKManagedObjectContext : NSManagedObjectContext

#pragma mark - Creation

+ (instancetype)createAtURL:(NSURL *)url
        withConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType;

#pragma mark - Master/Writer approach (separate contexts)

+ (instancetype)createMaster;
+ (instancetype)createWorker;


#pragma mark - For testing

+ (instancetype)createInMemory;


#pragma mark - Utility methods

+ (NSString *)managedObjectModelName;
+ (NSURL *)managedObjectModelURL;

+ (NSString *)persistentStoreFileName;
+ (NSURL *)persistentStoreDirectoryURL;
+ (NSURL *)persistentStoreURL;

@end

