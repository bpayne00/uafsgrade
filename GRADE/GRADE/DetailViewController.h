//
//  DetailViewController.h
//  GRADE
//
//  Created by Jonathan Freeman on 3/25/13.
//  Copyright (c) 2013 UAFS Capstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
