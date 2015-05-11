//
//  BDBDetailPublishedViewController.m
//  BrunoNews
//
//  Created by Bruno Domínguez on 10/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBDetailPublishedViewController.h"

@interface BDBDetailPublishedViewController ()



@end

@implementation BDBDetailPublishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

-(void)syncViewModel{
    self.titleDetail.text = [self.detailNew objectForKey:@"title"];
    self.contentDetail.text = [self.detailNew objectForKey:@"contentNew"];
    self.locationDetail.text = [self.detailNew objectForKey:@"location"];
    self.authorDetail.text = [self.detailNew objectForKey:@"author"];
}

@end
