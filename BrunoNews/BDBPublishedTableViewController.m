//
//  BDBPublishedTableViewController.m
//  BrunoNews
//
//  Created by Bruno Domínguez on 10/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBPublishedTableViewController.h"
#import "BDBSharedKeys.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "BDBDetailPublishedViewController.h"

@interface BDBPublishedTableViewController (){
    MSClient *client;
    NSArray *news;
    NSString *userFBId;
    NSString *tokenFB;
}

@end

@implementation BDBPublishedTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    client = [MSClient clientWithApplicationURLString:kAzureEndPoint applicationKey:kAzureAppKey];
    [self loadUserAuthInfo];
    
    
        NSString *key = @"author";
        NSString *keyState = @"state";
        NSString *state = @"Published";
        __block NSString *authorName;
    
    MSTable *table = [client tableWithName:@"brunoNews"];
    
        [client invokeAPI:@"getCurrentUser" body:nil HTTPMethod:@"GET" parameters:nil headers:nil completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
            authorName = [result objectForKey:@"name"];
            if (error) {
                NSLog(@"Error obteniendo usuario");
            }else{
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ && %K == %@", key, authorName, keyState, state];
                MSQuery *query = [[MSQuery alloc]initWithTable:table predicate:predicate];
                
                [query readWithCompletion:^(NSArray *items, NSInteger totalCount, NSError *error) {
                    NSSortDescriptor *sD = [[NSSortDescriptor alloc]initWithKey:@"_updatedAt" ascending:NO];
                    NSArray *ordered = [items sortedArrayUsingDescriptors:@[sD]];
                    news = [[NSArray alloc]initWithArray:ordered];
                    [self.tableView reloadData];
                }];
            }
        }];
    
    
    

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return news.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = [[news objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.detailTextLabel.text = [[news objectAtIndex:indexPath.row]objectForKey:@"author"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"detailPublished"]) {
        
        BDBDetailPublishedViewController *dP = [[BDBDetailPublishedViewController alloc]initWithCoder:nil];
        
        dP = segue.destinationViewController;
        dP.detailNew = [news objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    
    
}


-(void)loadUserAuthInfo{
    
    userFBId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    tokenFB = [[NSUserDefaults standardUserDefaults]objectForKey:@"tokenFB"];
    
    client.currentUser = [[MSUser alloc]initWithUserId:userFBId];
    client.currentUser.mobileServiceAuthenticationToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"tokenFB"];
    
}


@end
