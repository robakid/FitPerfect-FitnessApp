//
//  PerformanceDetailViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/16/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerformanceDetailViewController : UIViewController
@property(nonatomic,strong) NSString *PerformanceDetail;
@property (strong, nonatomic) IBOutlet UILabel *PerformanceDetailTitleLabel;

@end
