//
//  AvailabilityViewController.m
//  The_Core_Hotel
//
//  Created by Patrick Landin on 2/10/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "Reservation.h"

@interface AvailabilityViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;

@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelSegmentControl;
@property (strong,nonatomic) NSManagedObjectContext *context;

@end

@implementation AvailabilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  self.context = appDelegate.managedObjectContext;
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)checkAvailabilityPressed:(id)sender {
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
  NSString *selectedHotel = [self.hotelSegmentControl titleForSegmentAtIndex:self.hotelSegmentControl.selectedSegmentIndex];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.hotel.name MATCHES %@", selectedHotel];
  fetchRequest.predicate = predicate;
  
  NSFetchRequest *reservationFetch = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *reservationPredicate = [NSPredicate predicateWithFormat:@"room.hotel.name MATCHES %@ AND startDate >= %@ OR endDate <= %@", selectedHotel, self.startDate.date, self.endDate.date];
  
  reservationFetch.predicate = reservationPredicate;
  NSError *fetchError;
  
  NSArray *results = [self.context executeFetchRequest:reservationFetch error:&fetchError];
  NSMutableArray *rooms = [NSMutableArray new];
  for (Reservation *reservation in results) {
    [rooms addObject:reservation.room];
  }
  
  NSFetchRequest *openRoomsFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
  NSPredicate *roomsPredicate = [NSPredicate predicateWithFormat:@"hotel.name MATCHES %@ AND NOT (self IN %@)", selectedHotel, rooms];
  openRoomsFetchRequest.predicate = roomsPredicate;
  NSError *roomsError;
  NSArray *roomsResult = [self.context executeFetchRequest:openRoomsFetchRequest error:&roomsError];
  if (roomsError) {
    NSLog(@"%@", roomsError.localizedDescription);
  }
  
  NSLog(@"results : %lu", (unsigned long)roomsResult.count);
}



@end

