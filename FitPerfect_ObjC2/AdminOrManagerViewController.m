//
//  AdminOrManagerViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/3/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "AdminOrManagerViewController.h"
#import "DataModel.h"

@interface AdminOrManagerViewController ()

@end

@implementation AdminOrManagerViewController{
    DataModel *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    data = [[DataModel alloc]init];
    
    [data calculateNumberOfUsers];
    [data CreateSocialTable];
    [data collectAllChallengesInfo];
    [data collectLastLoggedInUsers];
    
    self.emailTF.returnKeyType = UIReturnKeyDone;
    [self.emailTF setDelegate:self];
    self.FNTF.returnKeyType = UIReturnKeyDone;
    [self.FNTF setDelegate:self];
    self.LNTF.returnKeyType = UIReturnKeyDone;
    [self.LNTF setDelegate:self];
    self.AgeTF.returnKeyType = UIReturnKeyDone;
    [self.AgeTF setDelegate:self];
    
    
    self.adminManagerProfileImg.image = [UIImage imageNamed:@"business_icon_group_1600_wht_7729.png"];
    
    [self.adminManagerProfileImg.layer setCornerRadius:CGRectGetHeight(self.adminManagerProfileImg.frame)/2];
    [self.adminManagerProfileImg.layer setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//keyboard disappears when return key pressed while in textfield
- (BOOL)textFieldShouldReturn:(UITextField *)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SeeStatsAction:(UIButton *)sender {
    int numberOfUsers = [data getTotalNumberOfUsers];
    int activeUsers = [data getLastLoggedInCount];
    int inactiveUsers = numberOfUsers - activeUsers;
    self.totalUsersValueLbl.text = [NSString stringWithFormat:@"%i", numberOfUsers];
    self.socialPostsValueLbl.text = [NSString stringWithFormat:@"%i", [data getNumberOfPosts]];
    self.challengesValueLbl.text = [NSString stringWithFormat:@"%i",[data getNumberOfChallenges]];
    self.activeUsersValueLbl.text = [NSString stringWithFormat:@"%i",activeUsers];
    self.inactiveUsersValueLbl.text = [NSString stringWithFormat:@"%i",inactiveUsers];
    
    self.userLBL.hidden=NO;
    self.userInactLBL.hidden=NO;
    self.userActLBL.hidden=NO;
    self.challengesLBL.hidden=NO;
    self.postsLBL.hidden=NO;
    
    self.totalUsersValueLbl.hidden=NO;
    self.socialPostsValueLbl.hidden=NO;
    self.challengesValueLbl.hidden=NO;
    self.activeUsersValueLbl.hidden=NO;
    self.inactiveUsersValueLbl.hidden=NO;
    
    self.AddUserBtn.hidden=YES;
    self.DeleteUserBtn.hidden=YES;
}
- (IBAction)ClearStatsAction:(UIButton *)sender {
    self.totalUsersValueLbl.hidden=YES;
    self.socialPostsValueLbl.hidden=YES;
    self.challengesValueLbl.hidden=YES;
    self.activeUsersValueLbl.hidden=YES;
    self.inactiveUsersValueLbl.hidden=YES;
    
    self.userLBL.hidden=YES;
    self.userInactLBL.hidden=YES;
    self.userActLBL.hidden=YES;
    self.challengesLBL.hidden=YES;
    self.postsLBL.hidden=YES;
    
    self.AddUserBtn.hidden=NO;
    self.DeleteUserBtn.hidden=NO;
}
- (IBAction)DeleteUser:(UIButton *)sender {
    self.emailTF.hidden=YES;;
    self.FNTF.hidden=YES;
    self.LNTF.hidden=YES;
    self.AgeTF.hidden=YES;
    
    [data deleteUser:self.emailTF.text];
}

- (IBAction)AddUser:(UIButton *)sender {
    self.emailTF.hidden=YES;;
    self.FNTF.hidden=YES;
    self.LNTF.hidden=YES;
    self.AgeTF.hidden=YES;
    
    [data signUpUser:self.FNTF.text secondParm:self.LNTF.text thirdParam:self.emailTF.text fourthParam:self.AgeTF.text];
}

- (IBAction)AccessUser:(UIButton *)sender {
    self.emailTF.hidden=NO;;
    self.FNTF.hidden=NO;
    self.LNTF.hidden=NO;
    self.AgeTF.hidden=NO;
}
@end
