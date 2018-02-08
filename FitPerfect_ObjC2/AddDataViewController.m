//
//  AddDataViewController.m
//  FitPerfect
//
//  Created by Janina Grayson on 12/8/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "AddDataViewController.h"
#import "DataModel.h"
#import "User.h"

@interface AddDataViewController ()

@end

@implementation AddDataViewController{
    DataModel *data;
    User *user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    data = [[DataModel alloc]init];
    user = [[User alloc] init];
    [user setUserEmail];
    
    self.stepsTF.returnKeyType = UIReturnKeyDone;
    [self.stepsTF setDelegate:self];
    
    self.floorsTF.returnKeyType = UIReturnKeyDone;
    [self.floorsTF setDelegate:self];
    
    self.milesTF.returnKeyType = UIReturnKeyDone;
    [self.milesTF setDelegate:self];
    
    self.calBurnTF.returnKeyType = UIReturnKeyDone;
    [self.calBurnTF setDelegate:self];
    
    self.calIntakeTF.returnKeyType = UIReturnKeyDone;
    [self.calIntakeTF setDelegate:self];
    
    self.heartTF.returnKeyType = UIReturnKeyDone;
    [self.heartTF setDelegate:self];
    
    self.activeMinutesTF.returnKeyType = UIReturnKeyDone;
    [self.activeMinutesTF setDelegate:self];
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

- (IBAction)addData:(UIButton *)sender {
    NSString *email = [user getUserEmail];
    [data addToDashboard:email secondParm:self.stepsTF.text thirdParam:self.milesTF.text fourthParam:self.calBurnTF.text fifthParam:self.floorsTF.text sixthParam:self.heartTF.text seventhParam:self.activeMinutesTF.text eighthParam:self.calIntakeTF.text];

}
@end
