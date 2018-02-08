//
//  ChallengesViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/16/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "ChallengesViewController.h"
#import "ChallengesDetailViewController.h"

@interface ChallengesViewController ()

@end

@implementation ChallengesViewController{
    NSArray *challenges;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    challenges = [NSArray arrayWithObjects:@"1 Hour", @"Daily", @"Weekly", @"Monthly", @"Community", nil];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"FitPerfect_header.jpg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// inform the table view how many rows are in the section. So let’s add the below code. The count: method simply returns the number of items in the “tableData” array
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [challenges count];
}

//called every time when a table row is displayed.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ChallengesCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [challenges objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ToChallengesDetail"]) {
        //row clicked on
        NSIndexPath *indexPath =[self.ChallengesTableView indexPathForSelectedRow];
        ChallengesDetailViewController *destViewController = segue.destinationViewController;
        //name will be settings name picked
        destViewController.challengesDetail = [challenges objectAtIndex:indexPath.row];
        //destViewController.title = destViewController.settingDetail;
        destViewController.title = @"";
    }
}


@end
