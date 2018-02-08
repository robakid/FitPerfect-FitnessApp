//
//  ProfileViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/3/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "DataModel.h"
#import "UserChallengesTableViewCell.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController{
    NSMutableArray *currentUserChallengesName;
    NSMutableArray *currentUserChallengesActivityType;
    NSMutableArray *currentUserChallengesWinner;
    DataModel *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //to turn rectangular image view into a circular image view
    
    data =[[DataModel alloc]init];
    
    User *user = [[User alloc] init];
    [user setUserEmail];
    [user setUserName];
    self.FullNameLbl.text = [user getUserName];
    //self.profileImg.image = [user getUserProfileImg];
    NSString *theImagePath = [[NSUserDefaults standardUserDefaults]valueForKey:@"profileImage"];
    UIImage *profileImage = [UIImage imageWithContentsOfFile:theImagePath];
    self.profileImg.image = profileImage;

    CGImageRef cgref = [self.profileImg.image CGImage];
    CIImage *cim = [self.profileImg.image CIImage];
    
    if (cim == nil && cgref == NULL)
    {
        self.profileImg.image = [UIImage imageNamed:@"action-mode.png"];
    }
    
    [self.profileImg.layer setCornerRadius:CGRectGetHeight(self.profileImg.frame)/2];
    [self.profileImg.layer setMasksToBounds:YES];
    
    
    self.EmailLbl.text = [user getUserEmail];
    
    [data collectChallengeInfoBasedOnParticipant:self.EmailLbl.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [currentUserChallengesName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"UserChallengeInfoCell";
    
    UserChallengesTableViewCell *cell = (UserChallengesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserChallengeInfoCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.challengeName.text = [currentUserChallengesName objectAtIndex:indexPath.row];
    cell.challengeActivity.text = [currentUserChallengesActivityType objectAtIndex:indexPath.row];
    cell.challengeWinner.text = [currentUserChallengesWinner objectAtIndex:indexPath.row];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getCurrentChallenges:(UIButton *)sender {
    
    NSDictionary *challengesInfo;
        
    challengesInfo = data.userChallengesDict;
        
    currentUserChallengesName = [NSMutableArray array];
    currentUserChallengesActivityType = [NSMutableArray array];
    currentUserChallengesWinner = [NSMutableArray array];

    for (id pair in challengesInfo) {
        NSLog(@"%@", pair);
        for (id key in pair){
            NSLog(@"%@", key);//field
            NSLog(@"%@", pair[key]);//value
            if ([key isEqualToString:@"Challenge_NAME"]) {
                [currentUserChallengesName addObject:pair[key]];
            }
            if ([key isEqualToString:@"Challenge_Activity_Type"]) {
                [currentUserChallengesActivityType addObject:pair[key]];
            }
            if ([key isEqualToString:@"Challenge_WINNER_Email"]) {
                [currentUserChallengesWinner addObject:pair[key]];
            }
        }
    }
    [self.profileChallengesTable reloadData];
    
}
@end
