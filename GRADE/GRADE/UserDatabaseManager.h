//
//  UserDatabaseManager.h
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 3/6/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface UserDatabaseManager : NSObject{
    sqlite3 *db;
}
@property (nonatomic, assign) sqlite3 *db;
- (NSString *)filePath;
- (void) openDB;
- (void) saveUser:(NSMutableDictionary *)dictionary;
- (NSMutableDictionary *) loadUser;
@end
