//
//  HealthKItViewController.h
//  FitPerfect_ObjC2
//
//  Created by Ana Robakidze on 12/8/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>

@interface HealthKItViewController : UIViewController
- (void)readHealthKitData;
- (void)queryHealthData;
@property (weak, nonatomic) IBOutlet UILabel *StepsLbl;
@property (weak, nonatomic) IBOutlet UILabel *FloorsLbl;
@property (weak, nonatomic) IBOutlet UILabel *HeartLbl;
@property (nonatomic,strong) NSString *steps;
@property (nonatomic,strong) NSString *miles;
@property (nonatomic,strong) NSString *calBurned;
@property (nonatomic,strong) NSString *floorsClimbed;
@property (nonatomic,strong) NSString *calIntake;
@property (nonatomic,strong) NSString *Heart;
@property (nonatomic,strong) NSString *activeMinutes;
@property (nonatomic, strong) HKHealthStore *healthStore;


@end



