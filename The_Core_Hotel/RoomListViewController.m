//
//  RoomListViewController.m
//  The_Core_Hotel
//
//  Created by Patrick Landin on 2/9/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "RoomListViewController.h"
#import "AddReservationViewController.h"
#import "Room.h"

@interface RoomListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *rooms;

@end

@implementation RoomListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.tableView.dataSource = self;
  self.rooms = self.selectedHotel.rooms.allObjects;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.rooms) {
    return self.rooms.count;
  } else {
    return 0;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOM_CELL" forIndexPath:indexPath];
  Room *room = self.rooms[indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@", room.number];
  return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier  isEqualToString:@"SHOW_RESERVATION"]) {
    AddReservationViewController *reservationVC = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    reservationVC.selectedRoom = [self.rooms objectAtIndex:indexPath.row];
  }
}

@end
