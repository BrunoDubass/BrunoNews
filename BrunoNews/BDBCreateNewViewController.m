//
//  BDBCreateNewViewController.m
//  BrunoNews
//
//  Created by Bruno Domínguez on 10/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBCreateNewViewController.h"
#import "BDBSharedKeys.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
@import CoreImage;

@interface BDBCreateNewViewController (){
    MSUser *user;
    MSClient *client;
    NSString *userFBId;
    NSString *tokenFB;
}

@end

@implementation BDBCreateNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    client = [MSClient clientWithApplicationURLString:kAzureEndPoint applicationKey:kAzureAppKey];
    [self loadUserAuthInfo];
    [client invokeAPI:@"getCurrentUser" body:nil HTTPMethod:@"GET" parameters:nil headers:nil completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
        self.authorNew.text = [result objectForKey:@"name"];
    }];
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

- (IBAction)pushNew:(id)sender {
    
    MSTable *table = [client tableWithName:@"brunoNews"];
    
//    NSDictionary *parameters = @{@"blobName":self.imageNew.image.description};
//    [client invokeAPI:@"getsasurl" body:nil HTTPMethod:@"GET" parameters:parameters headers:nil completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
//        NSLog(@"RESULT ----->>>>> %@", result);
//        [self handleImageToUploadAzureBlob:sasUrl blobImg:self.imageNew.image completionUploadTask:^(id result, NSError *error) {
//            if (error) {
//                NSLog(@"Error al subir blob");
//            }
//        }];
//    }];
    
    NSDictionary *new = @{@"title":self.titleNew.text, @"author":self.authorNew.text, @"contentNew":self.contentNew.text,@"location":self.locationNew.text, @"state":@"notPublished", @"value":@0};
    
    [table insert:new
       completion:^(NSDictionary *item, NSError *error) {
           
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Fail to insert new"
                                                           message:[NSString stringWithFormat:@"%@", error.localizedDescription]
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"Ok",nil];
            [alert show];
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"The new was inserted properly"
                                                           message:[NSString stringWithFormat:@"The new %@ was inserted properly", [item objectForKey:@"title"]]
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"Ok",nil];
            
            [alert show];
        }
    }];
    
}

- (IBAction)cameraNew:(id)sender {
    
    //Create
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    //Config
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    //Delegate asign
    picker.delegate = self;
    
    //Modal Presentation Style
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //Show
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         
        }];
    }

-(void)loadUserAuthInfo{
    
    userFBId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    tokenFB = [[NSUserDefaults standardUserDefaults]objectForKey:@"tokenFB"];
    
    client.currentUser = [[MSUser alloc]initWithUserId:userFBId];
    client.currentUser.mobileServiceAuthenticationToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"tokenFB"];
    
}

-(void)syncViewModel{
    NSLog(@"%@", client.currentUser);
    self.authorNew.text = user.description;
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //PICO DE MEMORIA si sacas la foto.
    
    UIImage* img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.imageNew.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //Ocultar el picker
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)handleImageToUploadAzureBlob:(NSURL *)theURL blobImg:(UIImage*)blobImg completionUploadTask:(void (^)(id result, NSError * error))completion{
    
    
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:theURL];
    
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    
    NSData *data = UIImageJPEGRepresentation(blobImg, 1.f);
    
    NSURLSessionUploadTask *uploadTask = [[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            NSLog(@"resultado --> %@", response);
        }
        
    }];
    [uploadTask resume];
}


@end
