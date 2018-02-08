//
//  AdminOrManagerViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/3/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminOrManagerViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *adminManagerProfileImg;
@property (strong, nonatomic) IBOutlet UILabel *totalUsersValueLbl;
@property (strong, nonatomic) IBOutlet UILabel *activeUsersValueLbl;
@property (strong, nonatomic) IBOutlet UILabel *inactiveUsersValueLbl;
@property (strong, nonatomic) IBOutlet UILabel *socialPostsValueLbl;
@property (strong, nonatomic) IBOutlet UILabel *challengesValueLbl;
@property (strong, nonatomic) IBOutlet UIButton *seeStatsBtn;
- (IBAction)SeeStatsAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *clearStatsBtn;
- (IBAction)ClearStatsAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *userLBL;
@property (strong, nonatomic) IBOutlet UILabel *userActLBL;
@property (strong, nonatomic) IBOutlet UILabel *userInactLBL;
@property (strong, nonatomic) IBOutlet UILabel *postsLBL;
@property (strong, nonatomic) IBOutlet UILabel *challengesLBL;

@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UITextField *FNTF;
@property (strong, nonatomic) IBOutlet UITextField *LNTF;
@property (strong, nonatomic) IBOutlet UITextField *AgeTF;
@property (strong, nonatomic) IBOutlet UIButton *AddUserBtn;
@property (strong, nonatomic) IBOutlet UIButton *DeleteUserBtn;
- (IBAction)DeleteUser:(UIButton *)sender;

- (IBAction)AddUser:(UIButton *)sender;

- (IBAction)AccessUser:(UIButton *)sender;




@end
