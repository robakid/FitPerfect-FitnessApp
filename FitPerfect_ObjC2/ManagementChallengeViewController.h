//
//  ManagementChallengeViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 12/7/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagementChallengeViewController : UIViewController <UITextViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *ChallengeNameTF;
@property (retain, nonatomic) IBOutlet UITextView *ChallengeDescriptionTV;
- (IBAction)AddChallenge:(UIButton *)sender;
- (IBAction)EditChallenge:(UIButton *)sender;
- (IBAction)DeleteChallenge:(UIButton *)sender;

@end
