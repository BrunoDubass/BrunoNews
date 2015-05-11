//
//  BDBDetailLectorViewController.m
//  BrunoNews
//
//  Created by Bruno Domínguez on 11/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBDetailLectorViewController.h"
#import "BDBSharedKeys.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface BDBDetailLectorViewController (){
    MSClient *client;
}

@end

@implementation BDBDetailLectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    client = [MSClient clientWithApplicationURLString:kAzureEndPoint applicationKey:kAzureAppKey];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

- (IBAction)vote:(id)sender {
    MSTable *table = [client tableWithName:@"brunoNews"];
    int value = [[self.detailNew objectForKey:@"value"]integerValue]+1;
    NSDictionary *dic = @{@"id":[self.detailNew objectForKey:@"id"], @"value":[NSNumber numberWithInt:value]};
    [table update:dic completion:^(NSDictionary *item, NSError *error) {
        if (error) {
            NSLog(@"Error updating votes");
        }
    }];
    
}

-(void)syncViewModel{
    self.titleDetail.text = [self.detailNew objectForKey:@"title"];
    self.contentDetail.text = [self.detailNew objectForKey:@"contentNew"];
    self.locationDetail.text = [self.detailNew objectForKey:@"location"];
    self.authorDetail.text = [self.detailNew objectForKey:@"author"];
    self.votesDetail.text = [NSString stringWithFormat:@"%@", [self.detailNew objectForKey:@"value"]];
}

@end
