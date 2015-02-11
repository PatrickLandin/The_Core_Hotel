//
//  AddReservationViewController.m
//  The_Core_Hotel
//
//  Created by Patrick Landin on 2/10/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "AddReservationViewController.h"
#import "Reservation.h"
#import "Guest.h"

@interface AddReservationViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;

@end

@implementation AddReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)makeResPressed:(id)sender {
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.selectedRoom.managedObjectContext];
  
  reservation.startDate = self.startDate.date;
  reservation.endDate = self.endDate.date;
  reservation.room = self.selectedRoom;
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.selectedRoom.managedObjectContext];
  guest.firstName = @"Patrick";
  guest.lastName = @"Landin";
  reservation.guest = guest;
  
  NSLog(@"%lu",(unsigned long)self.selectedRoom.reservations.count);
  
  NSError *saveError;
  [self.selectedRoom.managedObjectContext save:&saveError];
  
  if (saveError) {
    NSLog(@" %@",saveError.localizedDescription);
  }
}

@end
