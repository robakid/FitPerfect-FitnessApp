//
//  PerformanceSummaryViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/16/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerformanceSummaryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *PerformanceTableView;

@property (strong, nonatomic) IBOutlet UILabel *PerformanceStatLbl;

@end
