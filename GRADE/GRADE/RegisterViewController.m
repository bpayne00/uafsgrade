//
//  RegisterViewController.m
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 2/21/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import "RegisterViewController.h"
//#import "User.h"
#import "KinveyNetworkReachability.h"

@interface RegisterViewController (){
    //check for Internet connection
    KinveyNetworkReachability *knr;
}
@end

@implementation RegisterViewController
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize verifyPasswordTextField;
@synthesize registerButton;
//@synthesize udbm;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
    self.verifyPasswordTextField.text = @"";
    [self.usernameTextField becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //udbm = [[UserDatabaseManager alloc] init];
    knr = [[KinveyNetworkReachability alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerUser:(UIButton *)sender
{
    UIAlertView *alert;
    if([self.usernameTextField.text isEqualToString:@""]){
        //No username was entered
        alert = [[UIAlertView alloc] initWithTitle:@"Enter Username!" message:@"Please enter a username!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        if(self.verifyPasswordTextField.hasText) self.verifyPasswordTextField.text = @"";
        if(self.passwordTextField.hasText) self.passwordTextField.text = @"";
        [self.usernameTextField becomeFirstResponder];
    }else if (![self.passwordTextField.text isEqualToString:self.verifyPasswordTextField.text]){
        //Passwords don't match for verification
        alert = [[UIAlertView alloc] initWithTitle:@"Passwords Don't Match!" message:@"Please make sure your passwords match!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        self.passwordTextField.text = @"";
        self.verifyPasswordTextField.text = @"";
        [self.passwordTextField becomeFirstResponder];
    }else if ([self.passwordTextField.text isEqualToString:@""]){
        //No password was entered
        alert = [[UIAlertView alloc] initWithTitle:@"Password Required!" message:@"Please enter a password!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [self.passwordTextField becomeFirstResponder];
        if(self.verifyPasswordTextField.hasText) self.verifyPasswordTextField.text = @"";
    }else{
        if([knr isConnected]){
            //online-submit user info to Kinvey backend & SQLite local database
            [KCSUser userWithUsername:usernameTextField.text password:passwordTextField.text withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
                if (errorOrNil == nil) {
                    /*User *u = [[User alloc] initWithKey:[user.username stringByAppendingString:user.password] withUsername:user.username withPassword:user.password];
                    //add user to local database if not there
                    NSMutableDictionary *dbUser = [udbm loadUser];
                    BOOL exists = [dbUser valueForKey:u.key] != nil;
                    if(exists == NO){
                        //add user to dictionary
                        [dbUser setValue:u forKey:u.key];
                        //save dictionary with added entry to database
                        [udbm saveUser:dbUser];
                    }*/
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account Created!" message:@"Your account was created successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    BOOL wasUserError = [[errorOrNil domain] isEqual: KCSUserErrorDomain];
                    NSString* title = wasUserError ? [NSString stringWithFormat:NSLocalizedString(@"Could not create new user with username %@", @"create username error title"), user.username]: NSLocalizedString(@"An error occurred.", @"Generic error message");
                    NSString* message = wasUserError ? NSLocalizedString(@"Please choose a different username.", @"create username error message") : [errorOrNil localizedDescription];
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                                    message:message                                                           delegate:self
                                                          cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                                          otherButtonTitles:nil];
                    [alert show];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }else{
            //******NO OFFLINE YET-ALERT USER******//
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable To Register!" message:@"Offline registration not available yet!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            /*User *u = [[User alloc] initWithKey:[usernameTextField.text stringByAppendingString:passwordTextField.text] withUsername:usernameTextField.text withPassword:passwordTextField.text];
            //add user to local database if not there
            NSMutableDictionary *dbUser = [udbm loadUser];
            BOOL exists = [dbUser valueForKey:u.key] != nil;
            if(exists == NO){
                //add user to dictionary
                [dbUser setValue:u forKey:u.key];
                //save dictionary with added entry to database
                [udbm saveUser:dbUser];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Offline Mode!" message:@"You will be in offline mode until you connect to wifi!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account Exists!" message:@"The username you entered already exists!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }*/
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end
