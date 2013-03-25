//
//  MainContentViewController.m
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 2/21/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import "MainContentViewController.h"
#import "Course.h"
#import "CourseTableViewCell.h"
#import "KinveyNetworkReachability.h"

@interface MainContentViewController (){
    //check for Internet connection
    KinveyNetworkReachability *knr;
}
@property (nonatomic, retain) NSArray *courses;
@property (nonatomic, retain) KCSCachedStore *courseStore;
@property (nonatomic, retain) NSMutableDictionary *courseDictionary;
@end

@implementation MainContentViewController
@synthesize /*dbm, */courseStore, courseDictionary, courses;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //Initialize database manager object
    courseDictionary = [[NSMutableDictionary alloc] init];
    //dbm = [[DatabaseManager alloc] init];
    knr = [[KinveyNetworkReachability alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateList];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"courseCell";
    CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if (!cell) {
        cell = [[CourseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    Course *c = [self.courses objectAtIndex: indexPath.row];
    [cell setCourse:c];
    return cell;
}

- (void) updateList{
    if([knr isConnected]){
        [self updateListFromKinvey];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Offline!" message:@"You are offline!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    //([knr isConnected])?[self updateListFromKinvey]:[self updateListFromLocal];
}
- (void) updateListFromKinvey
{
    KCSCollection *collection = [KCSCollection collectionFromString:@"Courses" ofClass:[Course class]];
    self.courseStore = [KCSLinkedAppdataStore storeWithOptions:[NSDictionary dictionaryWithObjectsAndKeys:collection, KCSStoreKeyResource, [NSNumber numberWithInt:KCSCachePolicyNetworkFirst], KCSStoreKeyCachePolicy, self, KCSStoreKeyOfflineSaveDelegate, @"courseList",KCSStoreKeyUniqueOfflineSaveIdentifier, nil]];
    KCSQuery* query = [KCSQuery query];
    [courseStore queryWithQuery:query withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
        if (objectsOrNil) {
            self.courses = objectsOrNil;
            //load courseDictionary with retrieved Kinvey data
            //[self loadCourseDictionary];
            [self.tableView reloadData];
        }
    } withProgressBlock:nil];
}

//Used for offline via SQLite-will implement if time allows
/*- (void) updateListFromLocal{
    courseDictionary = [dbm loadCourses];
    self.courses = [courseDictionary allValues];
    [self.tableView reloadData];
}*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(IBAction)logout:(UIBarButtonItem *)sender{
    //Logout current user
    [[[KCSClient sharedClient] currentUser] logout];
    //Go to root view controller [login]
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//Used for offline via SQLite-will implement if time allows
/*- (void)loadCourseDictionary{
    //load courseDictionary with data from courses array
    for (int i=0; i<courses.count; i++) {
        Course *c = [courses objectAtIndex:i];
        [courseDictionary setValue:c forKey:[c.name stringByAppendingString:c.description]];
    }
    //save filled courseDictionary object to SQLite database
    //[dbm saveCourses:courseDictionary];
    [self.tableView reloadData];
}*/
@end
