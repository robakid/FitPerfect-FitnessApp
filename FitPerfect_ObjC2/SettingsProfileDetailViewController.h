//
//  SettingsProfileDetailViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/17/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>

@interface SettingsProfileDetailViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)seeGoalsAction:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *seeGoalsBtn;
@property(nonatomic,strong) NSString *settingProfileDetail;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIImageView *settingProfileImg;
- (IBAction)TakePhotoAction:(UIButton *)sender;
- (IBAction)SelectPhotoAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *takePhotoBtn;
@property (strong, nonatomic) IBOutlet UIButton *SelectPhotoBtn;
@property (strong, nonatomic) IBOutlet UIButton *SaveGoalsBtn;
- (IBAction)SaveGoalsAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *ConnectDeviceBtn;
- (IBAction)ConnectDeviceAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *StepsLbl;
@property (strong, nonatomic) IBOutlet UILabel *CaloriesBurnLbl;
@property (strong, nonatomic) IBOutlet UILabel *FloorsClimbedLbl;
@property (strong, nonatomic) IBOutlet UITextField *CalToBurnValueTF;
@property (strong, nonatomic) IBOutlet UILabel *ActiveMinutesLbl;
@property (strong, nonatomic) IBOutlet UITextField *StepsValueTF;
@property (strong, nonatomic) IBOutlet UITextField *FloorsValueTF;

@property (strong, nonatomic) IBOutlet UITextField *ActiveMinutesValueTF;
@property (nonatomic, strong) HKHealthStore *healthStore;
@end
