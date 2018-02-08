//
//  HealthKItViewController.m
//  FitPerfect_ObjC2
//
//  Created by Ana Robakidze on 12/8/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "HealthKItViewController.h"
#import <HealthKit/HealthKit.h>

@interface HealthKItViewController ()

@end

@implementation HealthKItViewController

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
    
    /* NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
     NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay
     fromDate:now];
     components.hour = 0;
     components.minute = 0;
     components.second = 0;
     
     
     NSDate *beginOfDay = [calendar dateFromComponents:components]; */
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:now options:HKQueryOptionStrictStartDate];
    
    HKStatisticsQuery *squery = [[HKStatisticsQuery alloc] initWithQuantityType:floors quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /*   HKQuantity *quantity = result.sumQuantity;
             double step = [quantity doubleValueForUnit:[HKUnit countUnit]];
             self.steps = [NSString stringWithFormat:@"%.0f",step];
             NSLog(@"Steps: %@",self.steps);
             self.StepsLbl.text = self.steps; */
            
            HKQuantity *quantity = result.sumQuantity;
            double floors = [quantity doubleValueForUnit:[HKUnit countUnit]];
            self.floorsClimbed = [NSString stringWithFormat:@"%.0f",floors];
            NSLog(@"Floors: %@",self.floorsClimbed);
            self.FloorsLbl.text = self.floorsClimbed;
            
            
            
        });
    }];
    
    [self.healthStore executeQuery:squery];
    //return self.steps;
    
    
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
            self.HeartLbl.text = self.miles;
            
            
            
            
            
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
            
            
            
            
            
            
        });
    }];
    
    [self.healthStore executeQuery:squery5];
    
    HKStatisticsQuery *squery6 = [[HKStatisticsQuery alloc] initWithQuantityType:typecaloriesconsumed quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            HKQuantity *quantity = result.sumQuantity;
            double caloriesburned = [quantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
            self.calBurned = [NSString stringWithFormat:@"%.0f", caloriesburned];
            NSLog(@"Calories consumed: %@",self.calBurned);
            
            
            
            
            
            
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



@end
