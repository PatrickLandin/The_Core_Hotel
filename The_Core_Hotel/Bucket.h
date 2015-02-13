//
//  Bucket.h
//  The_Core_Hotel
//
//  Created by Patrick Landin on 2/13/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bucket : NSObject

@property (strong,nonatomic) Bucket *next;
@property (strong,nonatomic) id data;
@property (strong,nonatomic) NSString *key;

@end
