//
//  SettingsViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 10/26/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
//- (IBAction)facebookLogout:(UIButton *)sender;

@end
