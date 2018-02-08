//
//  ManagementChallengeViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 12/7/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "ManagementChallengeViewController.h"
#import "DataModel.h"

@interface ManagementChallengeViewController ()

@end

@implementation ManagementChallengeViewController
{
    DataModel *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    data = [[DataModel alloc]init];
    
    self.ChallengeNameTF.returnKeyType = UIReturnKeyDone;
    [self.ChallengeNameTF setDelegate:self];

    [self.ChallengeDescriptionTV setDelegate:self];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

//keyboard disappears when return key pressed while in textfield
- (BOOL)textFieldShouldReturn:(UITextField *)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

- (IBAction)AddChallenge:(UIButton *)sender {
    
    NSString *name = [self.ChallengeNameTF.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *description = [self.ChallengeDescriptionTV.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [data startCommunityChallenge:name];
    [data addCommunityChallegefromCommunityChallengeTable:name secondParam:description];
}

- (IBAction)EditChallenge:(UIButton *)sender {
    
    NSString *name = [self.ChallengeNameTF.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *description = [self.ChallengeDescriptionTV.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [data updateCommunityChallegefromCommunityChallengeTable:name secondParam:description];
}

- (IBAction)DeleteChallenge:(UIButton *)sender {
    
    NSString *name = [self.ChallengeNameTF.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [data deleteCompletedCommmunityChallenge:name];
    [data deleteCommunityChallegefromCommunityChallengeTable:name];
}
@end
