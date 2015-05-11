//
//  BDBNew.m
//  BrunoNews
//
//  Created by Bruno Domínguez on 09/05/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBNew.h"

@implementation BDBNew

-(id)initWithTitle:(NSString*)title
         bodyOfNew:(NSString*)bodyOfNew
            author:(NSString*)author
         published:(BOOL)published
             votes:(int)votes
             photo:(UIImage*)photo
             ident:(NSString *)ident
             coors:(CLLocationCoordinate2D)coors{
    
    if (self = [super init]) {
        _title = title;
        _bodyOfNew = bodyOfNew;
        _author = author;
        _published = published;
        _votes = votes;
        _photo = photo;
        _ident = ident;
        _coors = coors;
    }
    return self;
}

@end
