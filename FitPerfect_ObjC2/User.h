//
//  User.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/9/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSDate *memberSince;
@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic,strong) NSString *stepsGoal;
@property (nonatomic,strong) NSString *caloriesBurnedGoal;
@property (nonatomic,strong) NSString *floorsGoal;
@property (nonatomic,strong) NSString *activeMinutesGoal;

-(NSString *) getUserLoginType;
-(void)setUserName;
-(NSString *) getUserName;
-(void)setUserEmail;
-(NSString *) getUserEmail;
-(void) setAll;
-(UIImage *)getUserProfileImg;
-(void) setUserProfileImg;
-(void) setUserGoals: (NSString *)steps secondParm: (NSString *)caloriesBurned thirdParm: (NSString *)floors lastParm: (NSString *)activeMinutes;
- (NSArray *)getUserGoals;




@end
