//
//  LoginViewController.m
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 2/21/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "KinveyNetworkReachability.h"

@interface LoginViewController (){
    //check for Internet connection
    KinveyNetworkReachability *knr;
}
@end

@implementation LoginViewController
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize loginButton;
//@synthesize udbm;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.usernameTextField becomeFirstResponder];
    //udbm = [[UserDatabaseManager alloc] init];
    knr = [[KinveyNetworkReachability alloc] init];
    if(![knr isConnected]){
        //******NO OFFLINE YET-ALERT USER******//
        UIAlertView *noOfflineAlert = [[UIAlertView alloc] initWithTitle:@"No Offline Availability!" message:@"The app cannot be used offline at this time!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [noOfflineAlert show];
        //We are offline-notify the user
        /*UIAlertView *offlineAlert = [[UIAlertView alloc] initWithTitle:@"Offline mode!" message:@"You are offline! Changes made locally will be queued and pushed the next time you are online." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [offlineAlert show];*/
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.usernameTextField becomeFirstResponder];
    if(![self.passwordTextField.text isEqualToString:@""]) self.passwordTextField.text=@"";
}

- (IBAction)login:(UIButton *)sender
{
    //Are we connected to the internet (via cellular data or wifi)?
    if([knr isConnected]){
        //We are-pull login data from Kinvey
        [KCSUser loginWithUsername:usernameTextField.text password:passwordTextField.text withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
            //User *u = [[User alloc] initWithKey:[usernameTextField.text stringByAppendingString:passwordTextField.text] withUsername:usernameTextField.text withPassword:passwordTextField.text];
            //check if user exists in local database
            //NSMutableDictionary *dbUser = [udbm loadUser];
            //BOOL exists = [dbUser valueForKey:u.key] != nil;
            
            if (/*!exists && */errorOrNil != nil) {
                //user not in local or Kinvey database
                NSString *title = @"Invalid Credentials!", *message=@"Wrong username or password. Please check and try again.";
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                self.usernameTextField.text = @"";
                self.passwordTextField.text = @"";
                [self.usernameTextField becomeFirstResponder];
            } else {
                //clear fields on success
                self.usernameTextField.text = @"";
                self.passwordTextField.text = @"";
                //logged in okay - go to the table
                UIAlertView *welcome = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:[NSString stringWithFormat:@"Welcome, %@",[[[KCSClient sharedClient] currentUser] username]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [welcome show];
                [self performSegueWithIdentifier:@"doLogin" sender:self];
            }
        }];
    }else{
        //******NO OFFLINE YET-ALERT USER******//
        //get login information entered
        /*User *u = [[User alloc] initWithKey:[usernameTextField.text stringByAppendingString:passwordTextField.text] withUsername:usernameTextField.text withPassword:passwordTextField.text];
        //check if user is in local database
        NSMutableDictionary *dbUser = [udbm loadUser];
        BOOL exists = [dbUser valueForKey:u.key] != nil;
        NSLog(@"Exists: %s",exists?"YES":"NO");
        if(exists == NO){*/
            /*UIAlertView *notRegisteredAlert = [[UIAlertView alloc] initWithTitle:@"Not Registered!" message:@"You must register first to login offline!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [notRegisteredAlert show];*/
        UIAlertView *noOfflineAlert = [[UIAlertView alloc] initWithTitle:@"No Offline Availability!" message:@"The app cannot be used offline yet!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [noOfflineAlert show];
            usernameTextField.text = @"";
            passwordTextField.text = @"";
            [usernameTextField becomeFirstResponder];
        /*}else{
            UIAlertView *welcome = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:[NSString stringWithFormat:@"Welcome, %@",usernameTextField.text] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [welcome show];
            [self performSegueWithIdentifier:@"doLogin" sender:self];
        }*/
    }
}
@end
