//
//  BDBDetailNotPublishedViewController.m
//  BrunoNews
//
//  Created by Bruno Domínguez on 10/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBDetailNotPublishedViewController.h"
#import "BDBSharedKeys.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface BDBDetailNotPublishedViewController (){
    MSClient *client;
    NSString *userFBId;
    NSString *tokenFB;
}

@end

@implementation BDBDetailNotPublishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    client = [MSClient clientWithApplicationURLString:kAzureEndPoint applicationKey:kAzureAppKey];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadUserAuthInfo];
    [self syncViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)syncViewModel{
    self.titleDetail.text = [self.detailNew objectForKey:@"title"];
    self.contentDetail.text = [self.detailNew objectForKey:@"contentNew"];
    self.locationDetail.text = [self.detailNew objectForKey:@"location"];
    self.authorDetail.text = [self.detailNew objectForKey:@"author"];
}

- (IBAction)publishNew:(id)sender {
    
    
    
    MSTable *table = [client tableWithName:@"brunoNews"];
    NSDictionary *up = @{@"id":[self.detailNew objectForKey:@"id"], @"state":@"Published"};
    [table update:up completion:^(NSDictionary *item, NSError *error) {
        if (error) {
            NSLog(@"Error al update");
        }else{
            NSLog(@"UPDATE ----->>>>>> %@", item);
        }
    }];
}

-(void)loadUserAuthInfo{
    
    userFBId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    tokenFB = [[NSUserDefaults standardUserDefaults]objectForKey:@"tokenFB"];
    
    client.currentUser = [[MSUser alloc]initWithUserId:userFBId];
    client.currentUser.mobileServiceAuthenticationToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"tokenFB"];
    
}



@end
