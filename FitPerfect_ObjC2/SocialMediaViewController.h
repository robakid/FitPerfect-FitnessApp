//
//  SocialMediaViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/28/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SocialMediaViewController : UIViewController <CLLocationManagerDelegate,UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *socialTableView;

- (IBAction)getData:(UIBarButtonItem *)sender;

@end


