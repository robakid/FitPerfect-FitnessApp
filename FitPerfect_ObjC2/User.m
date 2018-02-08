//
//  User.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/9/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "User.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SettingsProfileDetailViewController.h"

@implementation User
    
- (NSArray *)getUserGoals
{

    NSArray *goalsArray = [NSArray arrayWithObjects:self.stepsGoal,self.caloriesBurnedGoal, self.floorsGoal, self.activeMinutesGoal, nil];
    return goalsArray;
}

-(void) setUserGoals: (NSString *)steps secondParm: (NSString *)caloriesBurned thirdParm: (NSString *)floors lastParm: (NSString *)activeMinutes
{
    /*
    SettingsProfileDetailViewController *settingProfileVC = [[SettingsProfileDetailViewController alloc]init];
    steps = settingProfileVC.StepsValueTF.text.intValue;
    caloriesBurned = settingProfileVC.CalToBurnValueTF.text.intValue;
    floors = settingProfileVC.FloorsValueTF.text.intValue;
    activeMinutes = settingProfileVC.ActiveMinutesValueTF.text.intValue;
     */
    self.stepsGoal = steps;
    self.caloriesBurnedGoal = caloriesBurned;
    self.floorsGoal = floors;
    self.activeMinutesGoal = activeMinutes;
    
}

-(void) setUserProfileImg
{
    SettingsProfileDetailViewController *settingProfileVC = [[SettingsProfileDetailViewController alloc]init];
    self.profileImage = settingProfileVC.settingProfileImg.image;
}
-(UIImage *)getUserProfileImg
{
    return self.profileImage;
}

-(NSString *) getUserLoginType
{
    return [[NSUserDefaults standardUserDefaults]valueForKey:@"loginType"];
    
}

-(void)setUserName
{
    if ([[self getUserLoginType] isEqualToString:@"keychain"]) {
        NSString *firstName = [[NSUserDefaults standardUserDefaults]valueForKey:@"firstName"];
        NSString *lastName = [[NSUserDefaults standardUserDefaults]valueForKey:@"lastName"];
        self.name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];

    }
    if ([[self getUserLoginType] isEqualToString:@"facebook"]) {
        self.name = [FBSDKProfile currentProfile].name;
        
    }
    
}

-(NSString *) getUserName
{
    return self.name;
}

-(NSString *)getProfileImagePath
{
    return [[NSUserDefaults standardUserDefaults]valueForKey:@"profileImage"];
    //to retreive it:
    //NSString *theImagePath = [[NSUserDefaults standardUserDefaults]valueForKey:@"profileImage"];
    //UIImage *profileImage = [UIImage imageWithContentsOfFile:theImagePath];
}

-(void)setUserEmail
{
    if ([[self getUserLoginType] isEqualToString:@"keychain"]) {
        self.email = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
        
    }
    if ([[self getUserLoginType] isEqualToString:@"facebook"]) {
        self.email = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
        
    }
    
}
-(NSString *) getUserEmail
{
    return self.email;
}

-(void) setAll
{
    [self setUserName];
    [self setUserEmail];
}



@end
