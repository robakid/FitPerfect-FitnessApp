//
//  SignUpViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 10/26/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameSignUpTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameSignUpTF;
@property (weak, nonatomic) IBOutlet UITextField *emailSignUpTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordSignUpTF;
@property (weak, nonatomic) IBOutlet UITextField *ageSignUpTF;
- (IBAction)SignUpAction:(UIButton *)sender;
-(BOOL)CheckPasswordStrength:(UITextField *)passwrd;

@end
