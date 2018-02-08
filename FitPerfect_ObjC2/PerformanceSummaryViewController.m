//
//  PerformanceSummaryViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/16/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "PerformanceSummaryViewController.h"
#import "PerformanceDetailViewController.h"
#import "DataModel.h"
#import "User.h"

@interface PerformanceSummaryViewController ()

@end

@implementation PerformanceSummaryViewController{
    NSArray *performanceSelection;
    DataModel *data;
    User *user;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    data = [[DataModel alloc]init];
    user = [[User alloc] init];
    [user setUserEmail];
    
    [data collectUserAccountInfoForUser:[user getUserEmail]];
    performanceSelection = [NSArray arrayWithObjects:@"Average Steps - 7 days",@"Total Steps this week",@"Average Calories Burned - 7 days",@"Total Calories Burned this week",@"Daily Steps Goal",@"Daily Calories Burned Goal",@"Daily Active Minutes Goal",@"Daily Floors Goal",nil];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"FitPerfect_header.jpg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FitPerfect_header.jpg"]];
    //self.navigationItem.titleView =@"";
    //self.navigationController.navigationBar.topItem.title = @"";
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [DateFormatter stringFromDate:[NSDate date]];
    [data collectAllDashboardEntriesForUserAndDate:[user getUserEmail] secondParam:date];
    
    [data collectAllDashboardEntriesForUserAndYesterdayDate:[user getUserEmail]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [performanceSelection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PerformanceTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [performanceSelection objectAtIndex:indexPath.row];
    return cell;
}

//when a row is selected:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //retrieves the selected table cell by using the indexPath.
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *StatName = cell.textLabel.text;
    //performanceSelection = [NSArray arrayWithObjects:@"Average Steps - 7 days",@"Total Calories this week",@"Average Calories Burned - 7 days",@"Total Calories Burned this week",@"Steps Goal",@"Calories Burned Goal",@"Active Minutes Goal",@"Floors Goal",nil];
    
    int StatValue =0;
    //value pulled when querying database
    //goals data
    int stepsGoal =[data.stepsGoal intValue];
    int calBurnGoal =[data.calBurnGoal intValue];
    int activeGoal =[data.activeMinutesGoal intValue];
    int floorsGoal =[data.floorsGoal intValue];
    
    //todays data
    int todaysFloors = [data.floors intValue];
    int todaysCalBurn = [data.calBurn intValue];
    int todaysSteps = [data.steps intValue];
    int todaysActive = [data.active intValue];
    
    //yesterday data
    int yesterdaySteps = data.stepsYesterday;
    int yesterdayCalBurn = data.calBurnYesterday;
    
    //2 days ago data
    int steps2DaysAgo = data.steps2DaysAgo;
    int calBurn2DaysAgo = data.calBurn2DaysAgo;
    
    //3 days ago data
    int steps3DaysAgo = data.steps3DaysAgo;
    int calBurn3DaysAgo = data.calBurn3DaysAgo;
    
    //4 days ago data
    int steps4DaysAgo = data.steps4DaysAgo;
    int calBurn4DaysAgo = data.calBurn4DaysAgo;
    
    //5 days ago data
    int steps5DaysAgo = data.steps5DaysAgo;
    int calBurn5DaysAgo = data.calBurn5DaysAgo;
    
    //6 days ago data
    int steps6DaysAgo = data.steps6DaysAgo;
    int calBurn6DaysAgo = data.calBurn6DaysAgo;
    
    //total weekly steps
    int totalSteps = todaysSteps + yesterdaySteps + steps2DaysAgo + steps3DaysAgo + steps4DaysAgo + steps5DaysAgo + steps6DaysAgo;
    
    //avg weekly steps
    int avgSteps = totalSteps/7;
    
    //total weekly calories burned
    int totalCalBurn = todaysCalBurn + yesterdayCalBurn + calBurn2DaysAgo + calBurn3DaysAgo + calBurn4DaysAgo + calBurn5DaysAgo + calBurn6DaysAgo;
    
    //avg weekly calories burned
    int avgCalBurn = todaysCalBurn/7;
    
    if ([StatName isEqualToString:@"Average Steps - 7 days"]) {
        self.PerformanceStatLbl.text = [NSString stringWithFormat:@"%@: %i Steps",StatName,avgSteps];
    }
    if ([StatName isEqualToString:@"Total Steps this week"]) {
        self.PerformanceStatLbl.text = [NSString stringWithFormat:@"%@: %i Steps",StatName,totalSteps];
    }
    if ([StatName isEqualToString:@"Average Calories Burned - 7 days"]) {
        self.PerformanceStatLbl.text = [NSString stringWithFormat:@"%@: %i calories",StatName,avgCalBurn];
    }
    if ([StatName isEqualToString:@"Total Calories Burned this week"]) {
        self.PerformanceStatLbl.text = [NSString stringWithFormat:@"%@: %i calories",StatName,totalCalBurn];
    }
    if ([StatName isEqualToString:@"Daily Steps Goal"]) {
        StatValue = stepsGoal - todaysSteps;
        self.PerformanceStatLbl.text = [NSString stringWithFormat:@"Goal: %i Current: %i Still Needed: %i",stepsGoal,todaysSteps, StatValue];
    }
    if ([StatName isEqualToString:@"Daily Calories Burned Goal"]) {
        StatValue = calBurnGoal - todaysCalBurn;
        self.PerformanceStatLbl.text = [NSString stringWithFormat:@"Goal: %i Current: %i Still Needed: %i",calBurnGoal,todaysCalBurn, StatValue];
    }
    if ([StatName isEqualToString:@"Daily Active Minutes Goal"]) {
        StatValue = activeGoal - todaysActive;
        self.PerformanceStatLbl.text = [NSString stringWithFormat:@"Goal: %i Current: %i Still Needed: %i",activeGoal,todaysActive, StatValue];
    }
    if ([StatName isEqualToString:@"Daily Floors Goal"]) {
        StatValue = floorsGoal - todaysFloors;
        self.PerformanceStatLbl.text = [NSString stringWithFormat:@"Goal: %i Current: %i Still Needed: %i",floorsGoal,todaysFloors, StatValue];
    }
    
    
    //self.PerformanceStatLbl.text = [NSString stringWithFormat:@"%@: %i",StatName,StatValue];

    
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //NSString *str = cell.textLabel.text;
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"PerformanceDetail"]) {
        //row clicked on
        NSIndexPath *indexPath =[self.PerformanceTableView indexPathForSelectedRow];
         PerformanceDetailViewController *destViewController = segue.destinationViewController;
        //name will be settings name picked
        destViewController.PerformanceDetail = [performanceSelection objectAtIndex:indexPath.row];
        //destViewController.title = destViewController.PerformanceDetail;
        destViewController.title = @"";
        
    }
}
*/

@end
