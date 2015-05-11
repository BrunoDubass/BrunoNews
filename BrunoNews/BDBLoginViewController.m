//
//  BDBLoginViewController.m
//  BrunoNews
//
//  Created by Bruno Domínguez on 09/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBLoginViewController.h"
#import "BDBSharedKeys.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface BDBLoginViewController (){
    MSClient *client;
    NSString *userFBId;
    NSString *tokenFB;
}


@end

@implementation BDBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    client = [MSClient clientWithApplicationURLString:kAzureEndPoint applicationKey:kAzureAppKey];
    [self loginAppInViewController:self
                    withCompletion:^(NSArray *results) {
                        NSLog(@"Resultados -----> %@", results);
                        [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            NSLog(@"%@ - %@", idx, obj);
                        }];
                    }];
    [self loadUserAuthInfo];
    if (client.currentUser) {
        [self performSegueWithIdentifier:@"editor" sender:self];
    }else{
        [self performSegueWithIdentifier:@"lector" sender:self];
    }
    
    
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

#pragma mark - LOGIN

-(void)loginAppInViewController:(UIViewController*)controller withCompletion:(completeBlock)bloque{
    [self loadUserAuthInfo];
    if (client.currentUser) {
        return;
    }
    [client loginWithProvider:@"facebook"
                   controller:controller
                     animated:YES
                   completion:^(MSUser *user, NSError *error) {
                       
                       if (error) {
                           bloque(nil);
                       }else{
                           NSLog(@"user ---> %@", user);
                           [self saveAuthInfo];
                           bloque(@[user]);
                       }
                   }];
}

-(void)saveAuthInfo{
    [[NSUserDefaults standardUserDefaults]setObject:client.currentUser.userId forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults]setObject:client.currentUser.mobileServiceAuthenticationToken forKey:@"tokenFB"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(BOOL)loadUserAuthInfo{
    userFBId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    tokenFB = [[NSUserDefaults standardUserDefaults]objectForKey:@"tokenFB"];
    
    if (userFBId) {
        client.currentUser = [[MSUser alloc]initWithUserId:userFBId];
        client.currentUser.mobileServiceAuthenticationToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"tokenFB"];
        return YES;
    }
    return NO;
}


@end
