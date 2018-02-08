//
//  ViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 10/22/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Security/Security.h>
#import "UICKeyChainStore.h"
#import "User.h"
#import "DataModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    DataModel *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    data = [[DataModel alloc] init];
    //viewcontroller is textfield's delegate
    self.EmailLoginTextField.returnKeyType = UIReturnKeyDone;
    [self.EmailLoginTextField setDelegate:self];
    self.PasswordLoginTextField.returnKeyType = UIReturnKeyDone;
    [self.PasswordLoginTextField setDelegate:self];
    
    [data collectAllRowsInManagementBasedOnTypeForAdmin:@"admin1"];
    [data collectAllRowsInManagementBasedOnTypeForManager:@"Manager1"];
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

- (IBAction)LoginAction:(UIButton *)sender {
    
    //1. if either username or password is empty, present an alert to the user and return from the method
    if([self.EmailLoginTextField.text  isEqual: @""] || [self.PasswordLoginTextField.text  isEqual: @""]){
        UIAlertController *alertView=   [UIAlertController
                                      alertControllerWithTitle:@"Login Problem"
                                      message:@"Need to enter email and password."
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Foiled Again!" style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:okAction];
        [self presentViewController:alertView animated:YES completion:nil];
        return;
    }
    if ([self.EmailLoginTextField.text  isEqualToString: data.managementAdminName]  && [self.PasswordLoginTextField.text  isEqualToString: data.managementAdminPassword]) {
        [self performSegueWithIdentifier:@"ToAdminManagerViewFromLogin" sender:self];
        return;
    }
    if ([self.EmailLoginTextField.text  isEqualToString: data.managementManagerName] && [self.PasswordLoginTextField.text  isEqualToString: data.managementManagerPassword]) {
        [self performSegueWithIdentifier:@"ToAdminManagerViewFromLogin" sender:self];
        return;
    }
    
    //2. Dismiss keyboard if visible
    [self.EmailLoginTextField resignFirstResponder];
    [self.PasswordLoginTextField resignFirstResponder];
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"FitPerfectKeychain"];
    NSLog(@"Password: %@", [keychain stringForKey:@"password"]);
    
    if ([self checkLogin:self.EmailLoginTextField.text secondParamtr:self.PasswordLoginTextField.text] == true) {
        NSString *loginType = @"keychain";
        [[NSUserDefaults standardUserDefaults] setValue:loginType forKey:@"loginType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //update lastLogin for user
        [data updateLastLogin:self.EmailLoginTextField.text];
        
        //timer will go off and execute timerAction method every hour (3600 seconds) even when app is running in the background
        //NSTimer *dataTimer = [NSTimer scheduledTimerWithTimeInterval: 3600.0
                                                      //target: self
                                                    //selector:@selector(timerAction:)
                                                    //userInfo: nil repeats:YES];

        [self performSegueWithIdentifier:@"ToDashboardFromLoginViewController" sender:self];
        return;
    }
    else {
        //7. If login authentication fails, present an alert message to the user
        UIAlertController *alertView=   [UIAlertController
                                         alertControllerWithTitle:@"Login Problem"
                                         message:@"Wrong email address or password."
                                         preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Foiled Again!" style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:okAction];
        [self presentViewController:alertView animated:YES completion:nil];
        return;
        
    }

}



- (IBAction)FacebookLoginAction:(FBSDKLoginButton *)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
             [parameters setValue:@"email" forKey:@"fields"];
             
             [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
              startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
              {
                  NSLog(@"Fetched user is:%@", result);
                  for (id key in result) {
                      NSLog(@"key: %@ value: %@",key,result[key]);
                      if ([key isEqualToString:@"email"]) {

                              [[NSUserDefaults standardUserDefaults] setValue:result[key] forKey:@"email"
                           ];
                          [[NSUserDefaults standardUserDefaults]synchronize];
                          
                          NSString *fullName = [FBSDKProfile currentProfile].name;
                          NSArray * arr = [fullName componentsSeparatedByString:@" "];
                          NSString *firstN = arr[0];
                          NSString *lastN = arr[1];
                          [data signUpUser:firstN secondParm:lastN thirdParam:[[NSUserDefaults standardUserDefaults]valueForKey:@"email"] fourthParam:@"null"];
                          [data updateLastLogin:[[NSUserDefaults standardUserDefaults]valueForKey:@"email"]];
                      }
                      
                  }
              }];
             
             NSString *loginType = @"facebook";
             [[NSUserDefaults standardUserDefaults] setValue:loginType forKey:@"loginType"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             [self performSegueWithIdentifier:@"ToDashboardFromLoginViewController" sender:self];
         }
         
     }];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(profileUpdated:) name:FBSDKProfileDidChangeNotification object:nil];
    
    
}

-(void)profileUpdated:(NSNotification *) notification{
    NSLog(@"User name: %@",[FBSDKProfile currentProfile].name);
    NSLog(@"User ID: %@",[FBSDKProfile currentProfile].userID);
}

- (BOOL)checkLogin:(NSString *)email secondParamtr: (NSString *)password {
    //KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"FitPerfectKeychain" accessGroup:nil];
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"FitPerfectKeychain"];
    NSString *psswrd = [keychain stringForKey:@"password"];
    NSString *testemail = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    if ([password isEqualToString: psswrd] && [email isEqualToString: testemail]) {
        return true;
    }
    else {
        return false;
    }
}

//timerAction called when timer goes off
/*
-(void)timerAction:(NSTimer *)timer {
    NSLog(@"data Timer finished");
    //1.get participants device type from database
    //2. get dashboard type info based on device type
    //3. store info in database
}
 */

@end
