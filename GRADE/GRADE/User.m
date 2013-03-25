//
//  User.m
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 2/21/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import "User.h"
#define kKey @"key"
#define kUsername @"Username"
#define kPassword @"Password"

@implementation User
//@synthesize userId = _userId;
//@synthesize givenName = _givenName;
//@synthesize surname = _surname;
//@synthesize email = _email;
@synthesize key, username, password;
//@synthesize metadata = _metadata;

//Represents a user object
- (User *)initWithKey:(NSString *)k withUsername:(NSString *)u withPassword:(NSString *)p{
    self.key = k;
    self.username = u;
    self.password = p;
    return self;
}
//Used for object serialization via NSCoder
-(id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        key = [decoder decodeObjectForKey:kKey];
        username = [decoder decodeObjectForKey:kUsername];
        password = [decoder decodeObjectForKey:kPassword];
    }
    return [self initWithKey:key withUsername:username withPassword:password];
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:key forKey:kKey];
    [aCoder encodeObject:username forKey:kUsername];
    [aCoder encodeObject:password forKey:kPassword];
}
//Creates pairs for use with KCSStore
/*- (NSDictionary *)hostToKinveyPropertyMapping
//- (NSDictionary *) user
{
    return @{
             @"kinveyId"    :   KCSEntityKeyId,
//     @"givenName"   :   @"givenName",
//     @"surname"     :   @"surname",
//     @"email"       :   @"email",
     @"username"    :   @"username",
     @"password"    :   @"password",
//     @"metadata"    :   @"metadata"
     };
}*/
@end
