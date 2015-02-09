//
//  HotelListViewController.m
//  The_Core_Hotel
//
//  Created by Patrick Landin on 2/9/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "HotelListViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"

@interface HotelListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *hotels;

@end

@implementation HotelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.tableView.dataSource = self;
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSManagedObjectContext *context = appDelegate.managedObjectContext;
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
  // Predicate maybe?
  NSError *fetchError;
  
  NSArray *results = [context executeFetchRequest:fetchRequest error:&fetchError];
  if (!fetchError) {
    self.hotels = results;
    [self.tableView reloadData];
  }
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.hotels) {
    return self.hotels.count;
  } else {
    return 0;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOTEL_CELL" forIndexPath:indexPath];
  Hotel *hotel = self.hotels[indexPath.row];
  cell.textLabel.text = hotel.name;
  return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier  isEqualToString:@"SHOW_ROOMS"]) {
    RoomListViewController *roomsVC = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    roomsVC.selectedHotel = [self.hotels objectAtIndex:indexPath.row];
  }
}

@end
