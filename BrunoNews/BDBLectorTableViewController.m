//
//  BDBLectorTableViewController.m
//  BrunoNews
//
//  Created by Bruno Domínguez on 11/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBSharedKeys.h"
#import "BDBLectorTableViewController.h"
#import "BDBDetailLectorViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface BDBLectorTableViewController (){
    MSClient *client;
    NSArray *news;
}

@end

@implementation BDBLectorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    client = [MSClient clientWithApplicationURLString:kAzureEndPoint applicationKey:kAzureAppKey];
    
    NSString *keyState = @"state";
    NSString *state = @"Published";
    
    MSTable *table = [client tableWithName:@"brunoNews"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", keyState, state];
    MSQuery *query = [[MSQuery alloc]initWithTable:table predicate:predicate];
            
    [query readWithCompletion:^(NSArray *items, NSInteger totalCount, NSError *error) {
                NSSortDescriptor *sD = [[NSSortDescriptor alloc]initWithKey:@"_updatedAt" ascending:NO];
                NSArray *ordered = [items sortedArrayUsingDescriptors:@[sD]];
                news = [[NSArray alloc]initWithArray:ordered];
                [self.tableView reloadData];
            }];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    
    if ([segue.identifier isEqualToString:@"detailLectorPublished"]) {
        
        BDBDetailLectorViewController *dLP = [[BDBDetailLectorViewController alloc]initWithCoder:nil];
        
        dLP = segue.destinationViewController;
        dLP.detailNew = [news objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }

}




@end
