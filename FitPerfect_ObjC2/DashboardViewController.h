//
//  DashboardViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 10/26/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>

@interface DashboardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *fullNameLbl;
@property (strong, nonatomic) IBOutlet UITableView *DashboardTableView;

@property (strong, nonatomic) IBOutlet UIImageView *profileImage;


@property (nonatomic,strong) NSString *steps;
@property (nonatomic,strong) NSString *miles;
@property (nonatomic,strong) NSString *calBurned;
@property (nonatomic,strong) NSString *floorsClimbed;
@property (nonatomic,strong) NSString *calIntake;
@property (nonatomic,strong) NSString *Heart;
@property (nonatomic,strong) NSString *activeMinutes;
@property (nonatomic, strong) HKHealthStore *healthStore;

- (void)readHealthKitData;
- (void)queryHealthData;
@property (weak, nonatomic) IBOutlet UILabel *StepsLbl;
@property (weak, nonatomic) IBOutlet UILabel *FloorsLbl;
@property (weak, nonatomic) IBOutlet UILabel *HeartLbl;
@property (weak, nonatomic) IBOutlet UILabel *CalorieIntakeLbl;
@property (weak, nonatomic) IBOutlet UILabel *CalorieBurnedLbl;
@property (weak, nonatomic) IBOutlet UILabel *MilesLbl;
@property (strong, nonatomic) IBOutlet UILabel *ActiveLbl;

- (IBAction)reloadData:(UIButton *)sender;


@end
