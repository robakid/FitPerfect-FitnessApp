//
//  SignUpViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 10/26/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//
#import <Security/Security.h>
#import "SignUpViewController.h"
#import "UICKeyChainStore.h"
#import "DataModel.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController{
    DataModel *data;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstNameSignUpTF.returnKeyType = UIReturnKeyDone;
    [self.firstNameSignUpTF setDelegate:self];
    self.lastNameSignUpTF.returnKeyType = UIReturnKeyDone;
    [self.lastNameSignUpTF setDelegate:self];
    self.emailSignUpTF.returnKeyType = UIReturnKeyDone;
    [self.emailSignUpTF setDelegate:self];
    self.passwordSignUpTF.returnKeyType = UIReturnKeyDone;
    [self.passwordSignUpTF setDelegate:self];
    self.ageSignUpTF.returnKeyType = UIReturnKeyDone;
    [self.ageSignUpTF setDelegate:self];
    
    data = [[DataModel alloc] init];
    
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

- (IBAction)SignUpAction:(UIButton *)sender {
    //1. read hasLoginKey from NSUserDefaults which indicates whether a password has been to the Keychain. If the needed fields are not empty and hasLoginKey indicates no login has already been saved, then you can save the first and last name, email, and age to NSUserDefaults
    BOOL hasLoginKey = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasLoginKey"];
    if (hasLoginKey == false || hasLoginKey == true) {
        [[NSUserDefaults standardUserDefaults] setValue:self.firstNameSignUpTF.text forKey:@"firstName"
         ];
        [[NSUserDefaults standardUserDefaults] setValue:self.lastNameSignUpTF.text forKey:@"lastName"
         ];
        [[NSUserDefaults standardUserDefaults] setValue:self.emailSignUpTF.text forKey:@"email"
         ];
        [[NSUserDefaults standardUserDefaults] setValue:self.ageSignUpTF.text forKey:@"age"
         ];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    if ([self CheckPasswordStrength:self.passwordSignUpTF]) {
        
        [data signUpUser:self.firstNameSignUpTF.text secondParm:self.lastNameSignUpTF.text thirdParam:self.emailSignUpTF.text fourthParam:self.ageSignUpTF.text];
        
        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"FitPerfectKeychain"];
        [keychain setString:self.passwordSignUpTF.text forKey:@"password"];
        
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"hasLoginKey"];
        NSString *loginType = @"keychain";
        [[NSUserDefaults standardUserDefaults] setValue:loginType forKey:@"loginType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self performSegueWithIdentifier:@"ToDashboard" sender:self];
    }
    else{
        UIAlertController *alertView=   [UIAlertController
                                         alertControllerWithTitle:@"Password Error"
                                         message:@"Please enter a password greater than 8 characters consisting of uppercase letters, lowercase letters, and numbers."
                                         preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Try Again!" style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:okAction];
        [self presentViewController:alertView animated:YES completion:nil];
        return;
    }
    
    //2. Create keychain object and use mySetObject to save the password text to Keychain. Then set hasLoginKey in NSUserDefaults to true to indicate that a password has been saved to the keychain. Last, dismiss LoginView

    
}

-(BOOL)CheckPasswordStrength:(UITextField *)passwrd {
    if ([passwrd.text length] < 8) {
        return NO;
    }
    NSRange characterRange;
    //looks for lowercase letter characters in password
    characterRange = [passwrd.text rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    if (characterRange.length == 0){
        return NO;  // no lowercase letters
    }
    //looks for uppercase letter characters in password
    characterRange = [passwrd.text rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]];
    if (characterRange.length == 0){
        return NO;  // no uppercase letters
    }
    //looks for decimal digit characters in password
    characterRange = [passwrd.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (characterRange.length == 0){
        return NO;//no numbers
    }
    return YES;
}
@end