//
//  SettingsProfileDetailViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/17/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "SettingsProfileDetailViewController.h"
#import "User.h"
#import <HealthKit/HealthKit.h>
#import "DataModel.h"

@interface SettingsProfileDetailViewController ()

@end

@implementation SettingsProfileDetailViewController{
    DataModel *data;
    User *user;
    NSString *email;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    data = [[DataModel alloc] init];
    //user = [[User alloc] init];
    //[user setUserEmail];
    email = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    [data collectUserAccountInfoForUser:email];
    self.titleLbl.text = _settingProfileDetail;
    if ([_settingProfileDetail isEqualToString:@"Fitbit"]) {
        [self.ConnectDeviceBtn setTitle:@"Connect to Fitbit" forState:UIControlStateNormal];
    }
    if ([_settingProfileDetail isEqualToString:@"Jawbone Up"]) {
        [self.ConnectDeviceBtn setTitle:@"Connect to Jawbone" forState:UIControlStateNormal];
     }
    if ([_settingProfileDetail isEqualToString:@"Other"]) {
        [self.ConnectDeviceBtn setTitle:@"Set device type to Other" forState:UIControlStateNormal];
    }
    if ([_settingProfileDetail isEqualToString:@"Apple Watch"]) {
        [self.ConnectDeviceBtn setTitle:@"Connect to HealthKit" forState:UIControlStateNormal];
     }
    if ([_settingProfileDetail isEqualToString:@"Edit Profile Picture"]) {
        self.settingProfileImg.hidden = NO;
        self.takePhotoBtn.hidden=NO;
        self.SelectPhotoBtn.hidden = NO;
        self.ConnectDeviceBtn.hidden=YES;
        
        [self.settingProfileImg.layer setCornerRadius:CGRectGetHeight(self.settingProfileImg.frame)/2];
        [self.settingProfileImg.layer setMasksToBounds:YES];
        
        /*
         if statement executes if no camera is one the device like if it is a simulator
         */
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                  message:@"Device has no camera"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
            
            [myAlertView show];
            
        }
    }
    if ([_settingProfileDetail isEqualToString:@"Add/Edit Goals"]){
        self.StepsLbl.hidden = NO;
        self.CaloriesBurnLbl.hidden = NO;
        self.FloorsClimbedLbl.hidden = NO;
        self.ActiveMinutesLbl.hidden = NO;
        
        self.ConnectDeviceBtn.hidden=YES;
        
        self.StepsValueTF.hidden = NO;
        self.CalToBurnValueTF.hidden = NO;
        self.FloorsValueTF.hidden = NO;
        self.ActiveMinutesValueTF.hidden = NO;
        
        self.SaveGoalsBtn.hidden = NO;
        self.seeGoalsBtn.hidden=NO;
        
        

        

        //NSArray *userGoals = [user getUserGoals];
        //array order:self.stepsGoal,self.caloriesBurnedGoal, self.floorsGoal, self.activeMinutesGoal, nil];
        
            
        
        
        
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 When the user clicks (touch up inside) the “Take Photo” button, we have to create an UIImagePickerController and set its delegate to our AppViewController class. Also, we have to specify which kind of image picker we want to show, the camera with UIImagePickerControllerSourceTypeCamera, or a photo library with UIImagePickerControllerSourceTypePhotoLibrary; in this case we select the Camera. Once the picker has been crated, we have to present it modally with the method presentViewController
 */

- (IBAction)TakePhotoAction:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)SelectPhotoAction:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}



/*
 When the user takes a photo with the camera and resizes the image (photo resizing is allowed since we said allowsEditing = YES when we created the image picker) the didFinishPickingMediaWithInfo method is called. As the first argument we have the picker who called the method, something very useful if we have more than one image picker in our application, but that is not our case, and so, we ignore this parameter. The second argument is more interesting. It is a NSDictionary which contains, among other things, the original image and the edited image (accessible through the tag UIImagePickerControllerEditedImage)
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.settingProfileImg.image = chosenImage;
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"cached"]];
    
    NSLog((@"pre writing to file"));
    if (![imageData writeToFile:imagePath atomically:NO])
    {
        NSLog((@"Failed to cache image data to disk"));
    }
    else
    {
        NSLog(@"the cachedImagedPath is %@",imagePath);
    }
    [[NSUserDefaults standardUserDefaults] setValue:imagePath forKey:@"profileImage"
     ];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

/*
the user cancel the operation by touching the “Cancel” button of the image picker view. In that case the picker will call the imagePickerControllerDidCancel method. The implementation of this method is very simple, since what we have to do is just remove (dismiss) the picker controller
*/

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)SaveGoalsAction:(UIButton *)sender {
    /*
    int stepsGoal = self.StepsValueTF.text.intValue;
    int caloriesBurnedGoal = self.CalToBurnValueTF.text.intValue;
    int FloorsGoal = self.FloorsValueTF.text.intValue;
    int ActiveMinutesGoal = self.ActiveMinutesValueTF.text.intValue;
     */
    NSString *stepsGoal = self.StepsValueTF.text;
    NSString *caloriesBurnedGoal = self.CalToBurnValueTF.text;
    NSString *FloorsGoal = self.FloorsValueTF.text;
    NSString *ActiveMinutesGoal = self.ActiveMinutesValueTF.text;
    [data updateUserGoals:stepsGoal secondParm:caloriesBurnedGoal thirdParam:FloorsGoal fourthParam:ActiveMinutesGoal fifthParam:email];
    UIAlertController *alertView=   [UIAlertController
                                     alertControllerWithTitle:@"User Goals Update"
                                     message:@"Your performance goals have been updated."
                                     preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Enjoy!" style:UIAlertActionStyleDefault handler:nil];
    [alertView addAction:okAction];
    [self presentViewController:alertView animated:YES completion:nil];
    
    
}

- (IBAction)ConnectDeviceAction:(UIButton *)sender {
    if ([_settingProfileDetail isEqualToString:@"Fitbit"]) {
    }
    if ([_settingProfileDetail isEqualToString:@"Jawbone Up"]) {
     }
    if ([_settingProfileDetail isEqualToString:@"Other"]) {
        [data updateDeviceType:[[NSUserDefaults standardUserDefaults]valueForKey:@"email"] secondParm:@"Other"];
    }
    if ([_settingProfileDetail isEqualToString:@"Apple Watch"]) {
        
        [data updateDeviceType:[[NSUserDefaults standardUserDefaults]valueForKey:@"email"] secondParm:@"Apple_Watch"];

            self.healthStore = [[HKHealthStore alloc] init];
            if([HKHealthStore isHealthDataAvailable])
            {
                NSSet *readObjectTypes  = [NSSet setWithObjects:
                                           
                                           [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
                                           [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],
                                           [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned],
                                           [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed],
                                           [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate],
                                           [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed],
                                            [HKObjectType quantityTypeForIdentifier:HKWorkoutSortIdentifierDuration],
                                           
                                           
                                           
                                           nil];
                
                // Request access
                [self.healthStore requestAuthorizationToShareTypes:nil
                                                         readTypes:readObjectTypes
                                                        completion:^(BOOL success, NSError *error) {
                                                            
                                                            if(success == YES)
                                                            {
                                                                // ...
                                                            }
                                                            else
                                                            {
                                                                // Determine if it was an error or if the
                                                                // user just canceld the authorization request
                                                            }
                                                            
                                                        }];
                
            
            }
    }
}
        
- (IBAction)seeGoalsAction:(UIButton *)sender {
    self.StepsValueTF.text = [data getStepsGoal];
    self.CalToBurnValueTF.text = [data getCalBurnedGoal];
    self.FloorsValueTF.text = [data getFloorsGoal];
    self.ActiveMinutesValueTF.text = [data getActiveMinutesGoal];
}
@end
