//
//  BDBNew.h
//  BrunoNews
//
//  Created by Bruno Domínguez on 09/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import Foundation;
@import UIKit;
@import CoreLocation;

@interface BDBNew : NSObject

@property (copy, nonatomic)NSString *title;
@property (copy, nonatomic)NSString *bodyOfNew;
@property (copy, nonatomic)NSString *author;
@property (nonatomic)BOOL published;
@property (nonatomic)int votes;
@property (strong, nonatomic)UIImage *photo;
@property (copy, nonatomic)NSString *ident;
@property (nonatomic)CLLocationCoordinate2D coors;

-(id)initWithTitle:(NSString*)title
         bodyOfNew:(NSString*)bodyOfNew
            author:(NSString*)author
         published:(BOOL)published
             votes:(int)votes
             photo:(UIImage*)photo
             ident:(NSString*)ident
             coors:(CLLocationCoordinate2D)coors;

@end
