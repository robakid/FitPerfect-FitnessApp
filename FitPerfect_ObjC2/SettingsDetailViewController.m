//
//  SettingsDetailViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/8/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "SettingsDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Security/Security.h>
#import "UICKeyChainStore.h"
#import "SettingsProfileDetailViewController.h"
#import "LoginViewController.h"
#import "User.h"
#import "DataModel.h"

@interface SettingsDetailViewController ()

@end

@implementation SettingsDetailViewController{
    NSArray *device;
    NSArray *profile;
    //NSArray *locationShare;
    NSArray *logout;
    //User *user;
    DataModel *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    data =[[DataModel alloc] init];
    device = [NSArray arrayWithObjects:@"Fitbit", @"Jawbone Up", @"Other", @"Apple Watch", nil];
    profile = [NSArray arrayWithObjects:@"Edit Profile Picture", @"Add/Edit Goals", nil];
    
    if ([_settingDetail isEqualToString:@"Change Password"]) {
        self.detailTableView.hidden=YES;
        self.oldPasswordTextField.hidden=NO;
        self.NewPasswordTextField.hidden=NO;
        self.changePasswordButton.hidden=NO;
    }
    if ([_settingDetail isEqualToString:@"About application"]) {
        self.detailTableView.hidden=YES;
        self.AboutAppTextView.hidden=NO;
    }
    if ([_settingDetail isEqualToString:@"FAQ"]) {
        self.detailTableView.hidden=YES;
        self.FAQlabel.hidden=NO;
    }
    if ([_settingDetail isEqualToString:@"LogOut"]) {
        self.detailTableView.hidden=YES;
        self.appLogoutButton.hidden=NO;
        self.facebookLogoutButton.hidden=NO;
    }
    if ([_settingDetail isEqualToString:@"Share location"]) {
        self.detailTableView.hidden=YES;
        self.EnableLocationShareSwitch.hidden=NO;
        self.EnableShareLocationLbl.hidden=NO;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// inform the table view how many rows are in the section. So let’s add the below code. The count: method simply returns the number of items in the “tableData” array
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_settingDetail isEqualToString:@"Connect a device"]) {
        return [device count];
    }
    if ([_settingDetail isEqualToString:@"Edit user profile"]) {
        return [profile count];
    }
    //if ([_settingDetail isEqualToString:@"Share location"]) {
    //    return [locationShare count];
    //}
    //if ([_settingDetail isEqualToString:@"LogOut"]) {
    //    return [logout count];
    //}
    return 0;
}

//called every time when a table row is displayed.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SettingsDetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if ([_settingDetail isEqualToString:@"Connect a device"]) {
        cell.textLabel.text = [device objectAtIndex:indexPath.row];
    }
    if ([_settingDetail isEqualToString:@"Edit user profile"]) {
        cell.textLabel.text = [profile objectAtIndex:indexPath.row];
    }
    //if ([_settingDetail isEqualToString:@"Share location"]) {
    //    cell.textLabel.text = [locationShare objectAtIndex:indexPath.row];
    //}
   // if ([_settingDetail isEqualToString:@"LogOut"]) {
   //     cell.textLabel.text = [logout objectAtIndex:indexPath.row];
   // }

    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SettingProfileDetail"]) {
        //row clicked on
        NSIndexPath *indexPath =[self.detailTableView indexPathForSelectedRow];
        SettingsProfileDetailViewController *destViewController = segue.destinationViewController;
        //name will be settings name picked
        if ([_settingDetail isEqualToString:@"Connect a device"]) {
            destViewController.settingProfileDetail = [device objectAtIndex:indexPath.row];
        }
        if ([_settingDetail isEqualToString:@"Edit user profile"]) {
            destViewController.settingProfileDetail = [profile objectAtIndex:indexPath.row];
        }
        //destViewController.title = destViewController.settingDetail;
        destViewController.title = @"";
        
    }
    /*
    if ([segue.identifier isEqualToString:@"ToLogin"]) {
         LoginViewController *destViewController = segue.destinationViewController;
        destViewController.logoutDetail = @"Logged out";
    }
     */
    
}


- (IBAction)ApplicationLogout:(UIButton *)sender {
    
    

}
- (IBAction)FacebookLogout:(UIButton *)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc]init];
    if ([FBSDKAccessToken currentAccessToken]) {
        [login logOut];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
    }
    [self ReturnToLoginScreen];
    /*
    UIAlertController *alertView=   [UIAlertController alertControllerWithTitle:@"FitPerfect/Facebook Log Out" message:@"You have been logged out of our FitPerfect Facebook user account." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertView addAction:okAction];
    [self presentViewController:alertView animated:YES completion:nil];
    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    return;
     */
}

-(void)ReturnToLoginScreen
{
    [self performSegueWithIdentifier:@"ToLoginScreen" sender:self];
}

- (IBAction)changePassword:(UIButton *)sender {
    
    NSString *oldPasswrd = self.oldPasswordTextField.text;
    NSString *newPasswrd = self.NewPasswordTextField.text;
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"FitPerfectKeychain"];
    NSString *currentPasswrd = [keychain stringForKey:@"password"];
    if ([currentPasswrd isEqualToString:oldPasswrd]) {
        [keychain setString:newPasswrd forKey:@"password"];
        
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"hasLoginKey"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        UIAlertController *alertView=   [UIAlertController
                                         alertControllerWithTitle:@"Password Change"
                                         message:@"Your password information has been changed."
                                         preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Thanks!" style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:okAction];
        [self presentViewController:alertView animated:YES completion:nil];
        self.oldPasswordTextField.text = @"";
        self.NewPasswordTextField.text = @"";
    }
    else{
        UIAlertController *alertView=   [UIAlertController
                                         alertControllerWithTitle:@"Password Change Problem"
                                         message:@"Your password information does not match our files."
                                         preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Please try again!" style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:okAction];
        [self presentViewController:alertView animated:YES completion:nil];
        self.oldPasswordTextField.text = @"";
        self.NewPasswordTextField.text = @"";
        
    }
}
- (IBAction)EnableLocationShareAction:(UISwitch *)sender {
    if (self.EnableLocationShareSwitch.on) {
        self.EnableShareLocationLbl.text = @"Enable Share Location - ON";
        [self.EnableLocationShareSwitch setOn:YES animated:YES];
        //share location
        [data updateLocationEnabledBoolean:[[NSUserDefaults standardUserDefaults]valueForKey:@"email"] secondParm:1];

    }
    else{
        self.EnableShareLocationLbl.text = @"Enable Share Location - OFF";
        [self.EnableLocationShareSwitch setOn:NO animated:YES];
        [data updateLocationEnabledBoolean:[[NSUserDefaults standardUserDefaults]valueForKey:@"email"] secondParm:0];
    }
}
@end
