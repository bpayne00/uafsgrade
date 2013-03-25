//
//  UserDatabaseManager.m
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 3/6/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import "UserDatabaseManager.h"
#define kDataKey @"UserList"

@implementation UserDatabaseManager
@synthesize db;
- (NSString *)filePath{
    //path to store SQLite DB file in
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return ([path stringByAppendingPathComponent:@"userdb.sqlite"]);
}
- (void) openDB{
    //create NSFileManager for verifying local DB file exists
    NSFileManager *fm = [NSFileManager defaultManager];
    //for removing local DB in case it gets messed up or we want a different table structure
    //NSLog([fm removeItemAtPath:[self filePath] error:nil]?@"File removed!":@"File not removed!");
    //If SQLite DB file doesn't exist
    if(![fm fileExistsAtPath:[self filePath]]){
        if(![fm createFileAtPath:[self filePath] contents:nil attributes:nil]){
            //failed to create local SQLite DB file
			NSLog(@"[ERROR] SQLITE Database failed to initialize! File could not be created in application.");
		}else{
            //created local SQLite DB file-create users table [if not already there]
            if(sqlite3_open([[self filePath] UTF8String], &db) == SQLITE_OK){
                if(sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, user BLOB)", NULL, NULL, NULL) != SQLITE_OK){
                    NSLog(@"Failed to create users table!");
                }
                sqlite3_close(db);
            }else{
                NSLog(@"[ERROR] SQLITE Could not seed tables!");
            }
        }
    }
    //reopen connection to enable other classes/methods to call this and use DB file
    sqlite3_open([[self filePath] UTF8String], &db);
}
- (void) saveUser:(NSMutableDictionary *)dictionary{
    //data to archive
    NSMutableData *data = [[NSMutableData alloc] init];
    //archiver for serializing data
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //serialize dictionary with user credentials and assign key
    [archiver encodeObject:dictionary forKey:kDataKey];
    //close archiver
    [archiver finishEncoding];
    [self openDB];
    sqlite3_stmt *saveStmt;
    //prep statement
    sqlite3_prepare_v2(db, "INSERT INTO users(user) VALUES(?)", -1, &saveStmt, nil);
    //variable substitution
    if(sqlite3_bind_blob(saveStmt, 1, [data bytes], [data length], SQLITE_STATIC) != SQLITE_OK){
        NSLog(@"Failed to bind blob to statement!\nError: %s\nCode: %i",sqlite3_errmsg(db),sqlite3_errcode(db));
        //finalize SQL statement and close database
        sqlite3_finalize(saveStmt);
        sqlite3_close(db);
        return;
    }
    //execute SQL statement
    if (sqlite3_step(saveStmt) != SQLITE_DONE) {
        //SQL statement execution failed
		NSLog(@"[ERROR] SQLITE: Failed to insert into database! Error: '%s' - saveUser:", sqlite3_errmsg(db));
        //finalize SQL statement and close database
        sqlite3_finalize(saveStmt);
        sqlite3_close(db);
		return;
	}else{
        //success! finalize SQL statement and close database
        sqlite3_finalize(saveStmt);
        sqlite3_close(db);
    }
}

- (NSMutableDictionary *) loadUser{
    NSMutableDictionary *userDictionary;
    [self openDB];
    sqlite3_stmt *loadStmt;
    //prep statement
    sqlite3_prepare_v2(db, "SELECT user FROM users", -1, &loadStmt, nil);
    //execute SQL statement
    while (sqlite3_step(loadStmt) == SQLITE_ROW) {
        const void *blob = sqlite3_column_blob(loadStmt, 0);
        NSInteger bytes = sqlite3_column_bytes(loadStmt, 0);
        NSData *data = [[NSMutableData alloc] initWithBytes:blob length:bytes];
        //unarchiver for decoding serialized user data
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        //decode object and store in userDictionary
        userDictionary = [unarchiver decodeObjectForKey:kDataKey];
        //close unarchiver
        [unarchiver finishDecoding];
	}
    //finalize SQL statement and close database
    sqlite3_finalize(loadStmt);
    sqlite3_close(db);
    return userDictionary;
}
@end
