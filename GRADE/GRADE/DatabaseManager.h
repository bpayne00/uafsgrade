//
//  DatabaseManager.h
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 3/6/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseManager : NSObject{
    sqlite3 *db;
}
@property (nonatomic, assign) sqlite3 *db;
- (NSString *)filePath;
- (void) openDB;
- (void) saveCourses:(NSMutableDictionary *)dictionary;
- (NSMutableDictionary *)loadCourses;
@end
