//
//  FriendsTableViewController.h
//  FitPerfect
//
//  Created by Janina Grayson on 12/11/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>


- (IBAction)seePotentialFriends:(UIBarButtonItem *)sender;
- (IBAction)addAFriend:(UIButton *)sender;


@end
