//
//  ManagementSocialViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 12/7/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "ManagementSocialViewController.h"
#import "DataModel.h"

@interface ManagementSocialViewController ()

@end

@implementation ManagementSocialViewController{
    DataModel *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    data = [[DataModel alloc]init];
    
    self.postIDTextField.returnKeyType = UIReturnKeyDone;
    [self.postIDTextField setDelegate:self];
    
    self.firstNameTF.returnKeyType = UIReturnKeyDone;
    [self.firstNameTF setDelegate:self];
    
    self.lastNameTF.returnKeyType = UIReturnKeyDone;
    [self.lastNameTF setDelegate:self];
    
    self.emailTF.returnKeyType = UIReturnKeyDone;
    [self.emailTF setDelegate:self];
    
    self.activityTypeTF.returnKeyType = UIReturnKeyDone;
    [self.activityTypeTF setDelegate:self];
    
    self.postTextTF.returnKeyType = UIReturnKeyDone;
    [self.postTextTF setDelegate:self];
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

- (IBAction)DeletePost:(UIButton *)sender {
    int postID = self.postIDTextField.text.intValue;
    [data deleteSocialPost:postID];
}

- (IBAction)AddPost:(UIButton *)sender {
    
    NSString *email = [self.emailTF.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *firstName = [self.firstNameTF.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *lastName = [self.lastNameTF.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *postText = [self.postTextTF.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *activityType = [self.activityTypeTF.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [data addToSocialTable:email secondParm:firstName thirdParam:lastName fourthParam:postText fifthParam:activityType];
    
}
@end
