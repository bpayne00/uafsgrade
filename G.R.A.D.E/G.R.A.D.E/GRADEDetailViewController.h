//
//  GRADEDetailViewController.h
//  G.R.A.D.E
//
//  Created by Nathan Wesly on 3/3/13.
//  Copyright (c) 2013 GRADETEAM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRADEDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
