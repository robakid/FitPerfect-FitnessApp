//
//  DashboardTableViewCell.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/16/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *dashboardTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *dashboardItemValueLabel;
@property (nonatomic, weak) IBOutlet UIImageView *dashboardImageView;
@property (strong, nonatomic) IBOutlet UIView *progressBar;

@end
