//
//  BDBDetailLectorViewController.h
//  BrunoNews
//
//  Created by Bruno Domínguez on 11/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDBDetailLectorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleDetail;
@property (weak, nonatomic) IBOutlet UILabel *authorDetail;
@property (weak, nonatomic) IBOutlet UILabel *locationDetail;
@property (weak, nonatomic) IBOutlet UILabel *votesDetail;
@property (weak, nonatomic) IBOutlet UITextView *contentDetail;
@property (strong, nonatomic)NSDictionary *detailNew;

- (IBAction)vote:(id)sender;

@end
