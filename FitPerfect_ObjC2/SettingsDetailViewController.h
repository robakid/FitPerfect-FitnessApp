//
//  SettingsDetailViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/8/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) IBOutlet UIButton *appLogoutButton;
- (IBAction)FacebookLogout:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *facebookLogoutButton;
@property (strong, nonatomic) IBOutlet UILabel *FAQlabel;
@property (strong, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *NewPasswordTextField;

@property (strong, nonatomic) IBOutlet UIButton *changePasswordButton;
- (IBAction)changePassword:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextView *AboutAppTextView;
@property (strong, nonatomic) IBOutlet UISwitch *EnableLocationShareSwitch;
@property (strong, nonatomic) IBOutlet UILabel *EnableShareLocationLbl;

- (IBAction)EnableLocationShareAction:(UISwitch *)sender;

-(void)ReturnToLoginScreen;

@property(nonatomic,strong) NSString *settingDetail;

@end
