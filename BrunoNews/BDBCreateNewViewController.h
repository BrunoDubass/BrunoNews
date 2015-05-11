//
//  BDBCreateNewViewController.h
//  BrunoNews
//
//  Created by Bruno Domínguez on 10/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDBCreateNewViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageNew;
@property (weak, nonatomic) IBOutlet UITextField *titleNew;
@property (weak, nonatomic) IBOutlet UILabel *authorNew;
@property (weak, nonatomic) IBOutlet UILabel *locationNew;
@property (weak, nonatomic) IBOutlet UITextView *contentNew;

- (IBAction)pushNew:(id)sender;
- (IBAction)cameraNew:(id)sender;


@end
