//
//  RegisterViewController.h
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 2/21/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UserDatabaseManager.h"

@interface RegisterViewController : UIViewController
//@property (nonatomic, retain) UserDatabaseManager *udbm;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

-(IBAction)registerUser:(id)sender;
@end
