//
//  HotelService.h
//  The_Core_Hotel
//
//  Created by Patrick Landin on 2/11/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Room.h"
#import "Guest.h"

@interface HotelService : NSObject

@property (strong,nonatomic) CoreDataStack *coreDataStack;

-(instancetype)initForTesting;
+(id)sharedService;

-(Reservation *)bookReservationForGuest:(Guest *)guest forRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
