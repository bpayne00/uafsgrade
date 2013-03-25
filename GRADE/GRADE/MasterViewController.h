//
//  MasterViewController.h
//  GRADE
//
//  Created by Jonathan Freeman on 3/25/13.
//  Copyright (c) 2013 UAFS Capstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
