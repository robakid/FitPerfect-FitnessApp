//
//  DashboardViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 10/26/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "DashboardViewController.h"
#import "User.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "DashboardTableViewCell.h"
#import <HealthKit/HealthKit.h>
#import "DataModel.h"




@interface DashboardViewController ()

@end

@implementation DashboardViewController{
    NSArray *dashboardTitles;
    NSArray *dashboardImages;
    NSArray *dashboardValues;
    DataModel *data;
    User *user;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    user = [[User alloc] init];
    data = [[DataModel alloc] init];
    [user setUserName];
    [user setUserEmail];

    NSString *theImagePath = [[NSUserDefaults standardUserDefaults]valueForKey:@"profileImage"];
    UIImage *profileImage = [UIImage imageWithContentsOfFile:theImagePath];
    self.profileImage.image = profileImage;

    CGImageRef cgref = [self.profileImage.image CGImage];
    CIImage *cim = [self.profileImage.image CIImage];
    
    if (cim == nil && cgref == NULL)
    {
        self.profileImage.image = [UIImage imageNamed:@"action-mode.png"];
    }
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [DateFormatter stringFromDate:[NSDate date]];
    [data collectAllDashboardEntriesForUserAndDate:[user getUserEmail] secondParam:date];
    
    self.fullNameLbl.text = [user getUserName];
    dashboardTitles = [NSArray arrayWithObjects:@"Steps", @"Miles", @"Calories Burned", @"Floors Climbed", @"BMP Resting", @"Active Minutes", @"Calorie Intake", nil];
    dashboardImages = [NSArray arrayWithObjects:@"steps_icon.jpg", @"miles_icon.jpg", @"caloriesBurned_icon.jpg", @"floors_icon.jpg", @"heartRate_icon.jpg", @"activeMinutes_icon.jpg", @"caloriesintake_icon.jpg", nil];

    [self readHealthKitData];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dashboardTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"DashboardTableCell";
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [dashboardTitles objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[dashboardImages objectAtIndex:indexPath.row]];

    return cell;
    */
    
    DashboardTableViewCell *cell = (DashboardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DashboardTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.dashboardTitleLabel.text = [dashboardTitles objectAtIndex:indexPath.row];
    cell.dashboardImageView.image = [UIImage imageNamed:[dashboardImages objectAtIndex:indexPath.row]];
    
    cell.dashboardItemValueLabel.text = [dashboardValues objectAtIndex:indexPath.row];
    //NSString *HealthKitSteps = self.StepsLbl.text;
    //NSLog(@"HealthKitSteps: %@",HealthKitSteps);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)queryHealthData
{
    HKQuantityType *stepType =[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *floors = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    HKQuantityType *distance = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKQuantityType *typeheart = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    HKQuantityType *typecaloriesburned = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKQuantityType *typecaloriesconsumed = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];


    

    NSDate *now = [NSDate date];
    NSDate *startDate = [[NSCalendar autoupdatingCurrentCalendar] startOfDayForDate:now];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *date =[dateFormatter stringFromDate:startDate];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay
                                               fromDate:startDate];
    
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:now options:HKQueryOptionStrictStartDate];
    
    HKStatisticsQuery *squery = [[HKStatisticsQuery alloc] initWithQuantityType:floors quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            HKQuantity *quantity = result.sumQuantity;
            double floors = [quantity doubleValueForUnit:[HKUnit countUnit]];
            self.floorsClimbed = [NSString stringWithFormat:@"%.0f",floors];
              NSLog(@"Floors: %@",self.floorsClimbed);
            self.FloorsLbl.text = self.floorsClimbed;
            
            
            
        });
    }];
    
    [self.healthStore executeQuery:squery];
   
    
    
    HKStatisticsQuery *squery1 = [[HKStatisticsQuery alloc] initWithQuantityType:stepType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
             HKQuantity *quantity = result.sumQuantity;
             double step = [quantity doubleValueForUnit:[HKUnit countUnit]];
             self.steps = [NSString stringWithFormat:@"%.0f",step];
             NSLog(@"Steps: %@",self.steps);
             self.StepsLbl.text = self.steps;
           
            
           
            
            
                   });
    }];
    
    [self.healthStore executeQuery:squery1];
    //return self.steps;
    
    HKStatisticsQuery *squery3 = [[HKStatisticsQuery alloc] initWithQuantityType:distance quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            HKQuantity *quantity = result.sumQuantity;
            double distance = [quantity doubleValueForUnit:[HKUnit mileUnit]];
            self.miles = [NSString stringWithFormat:@"%.0f", distance];
            NSLog(@"Distance: %@",self.miles);
            self.MilesLbl.text = self.miles;
            
            
            
            
        });
    }];
    
    [self.healthStore executeQuery:squery3];
    
    
   

    HKStatisticsQuery *squery4 = [[HKStatisticsQuery alloc] initWithQuantityType:typeheart quantitySamplePredicate:predicate options:HKStatisticsOptionNone completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            HKQuantity *quantity = result.averageQuantity;
            double heart = [quantity doubleValueForUnit:[HKUnit unitFromString:@"count/min"]];
            self.HeartLbl.text = [NSString stringWithFormat:@"%.f",heart];
             NSLog(@"Heart: %@",self.Heart);
        }
                       );
    }];
    
      [self.healthStore executeQuery:squery4];
    
    
    
    HKStatisticsQuery *squery5 = [[HKStatisticsQuery alloc] initWithQuantityType:typecaloriesburned quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            HKQuantity *quantity = result.sumQuantity;
            double caloriesburned = [quantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
            self.calBurned = [NSString stringWithFormat:@"%.0f", caloriesburned];
            NSLog(@"Calories Burned: %@",self.calBurned);
            self.CalorieBurnedLbl.text = self.calBurned;
            
            
            
            
            
        });
    }];
    
    [self.healthStore executeQuery:squery5];
    
    HKStatisticsQuery *squery6 = [[HKStatisticsQuery alloc] initWithQuantityType:typecaloriesconsumed quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            HKQuantity *quantity = result.sumQuantity;
            double calorieIntake = [quantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
            self.calIntake = [NSString stringWithFormat:@"%.0f", calorieIntake];
            NSLog(@"Calories consumed: %@",self.calIntake);
            self.CalorieIntakeLbl.text = self.calIntake;
            
            
            
            
            
        });
    }];
    
    [self.healthStore executeQuery:squery6];

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate]
                                                           predicate:[HKSampleQuery predicateForObjectsWithNoCorrelation]
                                                               limit:20
                                                     sortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO]]
                                                      resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              NSMutableArray *heart = [NSMutableArray arrayWithArray:results];
                                                          });
                                                      }];
    // don't forget to run the query after you create it!
    [_healthStore executeQuery:query];
    
   }


    - (void)readHealthKitData
    {
        
        self.healthStore = [[HKHealthStore alloc] init];
        if([HKHealthStore isHealthDataAvailable])
        {
            HKQuantityType *stepType =[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
            HKQuantityType *floors = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
            
            [self.healthStore requestAuthorizationToShareTypes:nil readTypes:[NSSet setWithObject:floors] completion:^(BOOL success, NSError *error) {
                if(success)
                {
                    [self queryHealthData];
                    NSLog(@"Connection to HealthKit successful");
                    
                }
                
            }];
            
        }
        
    }
   


- (IBAction)reloadData:(UIButton *)sender {
    self.FloorsLbl.text = data.floors;
    self.CalorieIntakeLbl.text = data.calIntake;
    self.CalorieBurnedLbl.text = data.calBurn;
    self.HeartLbl.text = data.heart;
    self.MilesLbl.text = data.miles;
    self.StepsLbl.text = data.steps;
    self.ActiveLbl.text = data.active;
    
}
@end
