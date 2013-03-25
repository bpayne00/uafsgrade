//
//  Course.h
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 2/25/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KinveyKit/KinveyKit.h>

//Represents a course object
@interface Course : NSObject <KCSPersistable>
@property (nonatomic, retain) NSString *kinveyId;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
-(Course *)initWithKey:(NSString *)k withName:(NSString *)n withDescription:(NSString *)d;
@end
