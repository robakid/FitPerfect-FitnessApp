//
//  ChallengesDetailViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/16/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "ChallengesDetailViewController.h"
#import "Challenges_FriendsDetailViewController.h"
#import "DataModel.h"

@interface ChallengesDetailViewController ()

@end

@implementation ChallengesDetailViewController{
    NSArray *challengeType;
    NSArray *communityChallenges;
    DataModel *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data=[[DataModel alloc]init];
    [data getCurrentCommunityChallenges];
    
    // Do any additional setup after loading the view.
    if ([_challengesDetail isEqualToString:@"1 Hour"] || [_challengesDetail isEqualToString:@"Daily"] || [_challengesDetail isEqualToString:@"Monthly"] || [_challengesDetail isEqualToString:@"Weekly"]) {
    challengeType = [NSArray arrayWithObjects:@"Steps", @"Floors Climbed", @"Calories Burned",@"Custom", nil];
    }
    //communityChallenges = getArrayOfCommunityChallengesFromDatabase(); //will need to be NSMutableArray
    if ([_challengesDetail isEqualToString:@"Community"]) {
        self.showCommunityChallengesBtn.hidden=NO;
        communityChallenges = data.currentCommunityChallenges;
    }
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"FitPerfect_header.jpg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_challengesDetail isEqualToString:@"1 Hour"] || [_challengesDetail isEqualToString:@"Daily"] || [_challengesDetail isEqualToString:@"Monthly"] || [_challengesDetail isEqualToString:@"Weekly"]) {
        return [challengeType count];
    }
    if ([_challengesDetail isEqualToString:@"Community"]) {
        return [communityChallenges count];
    }
    return 0;
}

//called every time when a table row is displayed.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ChallengesDetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if ([_challengesDetail isEqualToString:@"1 Hour"] || [_challengesDetail isEqualToString:@"Daily"] || [_challengesDetail isEqualToString:@"Monthly"] || [_challengesDetail isEqualToString:@"Weekly"]) {
        cell.textLabel.text = [challengeType objectAtIndex:indexPath.row];
    }
    if ([_challengesDetail isEqualToString:@"Community"]) {
        cell.textLabel.text = [communityChallenges objectAtIndex:indexPath.row];
    }
    
    return cell;
}


#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 if ([segue.identifier isEqualToString:@"ToChallenges_FriendsDetail"]) {
 //row clicked on
 NSIndexPath *indexPath =[self.ChallengesDetailTableView indexPathForSelectedRow];
 Challenges_FriendsDetailViewController *destViewController = segue.destinationViewController;
 //name will be settings name picked
     if ([_challengesDetail isEqualToString:@"1 Hour"] || [_challengesDetail isEqualToString:@"Daily"] || [_challengesDetail isEqualToString:@"Monthly"] || [_challengesDetail isEqualToString:@"Weekly"]) {
          destViewController.challenges_friendsDetail = [challengeType objectAtIndex:indexPath.row];
         destViewController.challengeName = _challengesDetail;
     }
     
     if ([_challengesDetail isEqualToString:@"Community"]) {
          destViewController.challenges_friendsDetail = [communityChallenges objectAtIndex:indexPath.row];
     }
      
 destViewController.title = @"";
 }
 }

- (IBAction)showCommunityChallenges:(UIButton *)sender {
    communityChallenges = data.currentCommunityChallenges;
    [self.ChallengesDetailTableView reloadData];
    
}
@end
