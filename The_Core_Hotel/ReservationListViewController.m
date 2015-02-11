//
//  ReservationListViewController.m
//  The_Core_Hotel
//
//  Created by Patrick Landin on 2/11/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "ReservationListViewController.h"
#import "AddReservationViewController.h"
#import "HotelService.h"

@interface ReservationListViewController () <UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ReservationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.fetchedResultsController.delegate = self;
  self.tableView.dataSource = self;
  
  NSManagedObjectContext *context = [[HotelService sharedService] coreDataStack].managedObjectContext;
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"room == @%", self.selectedRoom];
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:true];
  fetchRequest.predicate = predicate;
  fetchRequest.sortDescriptors = @[sortDescriptor];
  self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
  NSError *fetchError;
  [self.fetchedResultsController performFetch:&fetchError];
  if (fetchError) {
    NSLog(@" %@", fetchError);
  }
    // Do any additional setup after loading the view.
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView endUpdates];
}

//-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
//  
//  switch (type) {
//    case NSFetchedResultsChangeInsert:
//      <#statements#>
//      break;
//    case NSFetchedResultsChangeUpdate:
//      break;
//    case NSFetchedResultsChangeMove:
//      break;
//    case NSFetchedResultsChangeDelete:
//      break;
//    default:
//      break;
//  }
//  
//}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 0;
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  
//  return cell;
//}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"ADD_RESERVATION"]) {
    AddReservationViewController *addReservationVC = segue.destinationViewController;
    addReservationVC.selectedRoom = self.selectedRoom;
  }
}

@end
