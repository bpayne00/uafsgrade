//
//  KinveyNetworkReachability.m
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 3/12/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import "KinveyNetworkReachability.h"

@implementation KinveyNetworkReachability
-(BOOL)isConnected{
    reachability = [[KCSClient sharedClient] kinveyReachability];
    isCell = reachability.isReachableViaWWAN;
    isWifi = reachability.isReachableViaWiFi;
    return (isCell || isWifi);
}
@end
