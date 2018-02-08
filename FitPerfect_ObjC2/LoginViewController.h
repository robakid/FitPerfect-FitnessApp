//
//  ViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 10/22/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *EmailLoginTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordLoginTextField;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property(nonatomic,strong) NSString *logoutDetail;
- (IBAction)LoginAction:(UIButton *)sender;
- (IBAction)FacebookLoginAction:(FBSDKLoginButton *)sender;




@end

