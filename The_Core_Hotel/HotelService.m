//
//  HotelService.m
//  The_Core_Hotel
//
//  Created by Patrick Landin on 2/11/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "HotelService.h"

@implementation HotelService

+(id)sharedService {
  static HotelService *mySharedService = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
    mySharedService = [[self alloc] init];
  });
  return mySharedService;
}

-(instancetype) init {
  self = [super init];
  if (self) {
    self.coreDataStack = [[CoreDataStack alloc] init];
  }
  return self;
}

-(instancetype) initForTesting {
  self = [super init];
  if (self) {
    self.coreDataStack = [[CoreDataStack alloc] initForTesting];
  }
  return self;
}

-(Reservation)

@end
