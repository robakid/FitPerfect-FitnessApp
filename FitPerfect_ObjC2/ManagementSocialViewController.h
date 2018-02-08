//
//  ManagementSocialViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 12/7/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagementSocialViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *postIDTextField;
- (IBAction)DeletePost:(UIButton *)sender;
- (IBAction)AddPost:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextField *firstNameTF;

@property (strong, nonatomic) IBOutlet UITextField *lastNameTF;
@property (strong, nonatomic) IBOutlet UITextField *emailTF;

@property (strong, nonatomic) IBOutlet UITextField *activityTypeTF;
@property (strong, nonatomic) IBOutlet UITextField *postTextTF;



@end
