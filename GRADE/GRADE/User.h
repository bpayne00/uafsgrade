//
//  User.h
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 2/21/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KinveyKit/KinveyKit.h>

//Represents a user object
@interface User : NSObject <NSCoding>//, KCSPersistable>
//@property (nonatomic, retain) NSString *userId;
//@property (nonatomic, retain) NSString *givenName;
//@property (nonatomic, retain) NSString *surname;
//@property (nonatomic, retain) NSString *email;
//@property (nonatomic, retain) NSString *kinveyId;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
//@property (nonatomic, retain) KCSMetadata *metadata;
- (User *)initWithKey:(NSString *)k withUsername:(NSString *)u withPassword:(NSString *)p;
@end
