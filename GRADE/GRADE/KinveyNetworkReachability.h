//
//  KinveyNetworkReachability.h
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 3/12/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KinveyKit/KinveyKit.h>

@interface KinveyNetworkReachability : NSObject{
    KCSReachability *reachability;
    BOOL isCell, isWifi;
}
-(BOOL)isConnected;

@end
