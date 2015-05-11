//
//  BDBLoginViewController.h
//  BrunoNews
//
//  Created by Bruno Domínguez on 09/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^profileCompletion)(NSDictionary * profInfo);
typedef void(^completeBlock)(NSArray *results);
typedef void(^completeOnError)(NSError *err);
typedef void(^completionWithURL)(NSURL * theUrl, NSError *error);

@interface BDBLoginViewController : UIViewController

@end
