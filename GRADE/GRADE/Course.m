//
//  Course.m
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 2/25/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import "Course.h"
#define kKey @"key"
#define kKinveyId @"kinveyId"
#define kName @"name"
#define kDescription @"description"

@implementation Course
@synthesize kinveyId, key, name, description;

//Represents a course object
- (Course *)initWithKey:(NSString *)k withName:(NSString *)n withDescription:(NSString *)d{
    self.key = k;
    self.kinveyId = KCSEntityKeyId;
    self.name = n;
    self.description = d;
    return self;
}
//Used for object serialization via NSCoder
-(id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        key = [decoder decodeObjectForKey:kKey];
        kinveyId = [decoder decodeObjectForKey:kKinveyId];
        name = [decoder decodeObjectForKey:kName];
        description = [decoder decodeObjectForKey:kDescription];
    }
    return [self initWithKey:key withName:name withDescription:description];
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:key forKey:kKey];
    [aCoder encodeObject:kinveyId forKey:kKinveyId];
    [aCoder encodeObject:name forKey:kName];
    [aCoder encodeObject:description forKey:kDescription];
}
//Creates pairs for use with KCSStore
- (NSDictionary *)hostToKinveyPropertyMapping
{
    return @{
     @"kinveyId"    :   KCSEntityKeyId,
     @"name"        :   @"name",
     @"description" :   @"description"
     };
}
@end
