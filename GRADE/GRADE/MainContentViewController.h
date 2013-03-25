//
//  MainContentViewController.h
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 2/21/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DatabaseManager.h"
#import <KinveyKit/KCSOfflineSaveStore.h>

@interface MainContentViewController : UITableViewController <KCSOfflineSaveDelegate>
//@property (nonatomic, retain) DatabaseManager *dbm;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
//Used for offline via SQLite-will implement if time allows
//- (void)loadCourseDictionary;
- (IBAction)logout:(id)sender;
@end
