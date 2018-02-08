//
//  SocialMediaPostViewController.m
//  FitPerfect
//
//  Created by Ana Robakidze on 12/13/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "SocialMediaPostViewController.h"
#import "DataModel.h"

@interface SocialMediaPostViewController ()

@end

@implementation SocialMediaPostViewController{
    DataModel *data;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    CLLocation *currentLocation;
    NSString *address;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    data = [[DataModel alloc]init];
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
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





- (IBAction)Cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (IBAction)PostToNewsfeed:(UIButton *)sender {
    
    NSString *firstName = [self.FName.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    NSString *lastName = [self.LName.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *activityType = [self.Activity.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *postText = [self.postText.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    postText = [postText stringByReplacingOccurrencesOfString:@"\n" withString:@"%20"];
    

    [data addToSocialTable:[[NSUserDefaults standardUserDefaults]valueForKey:@"email"] secondParm:firstName thirdParam:lastName fourthParam:postText fifthParam:activityType];
}

- (IBAction)TakePicture:(id)sender {
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];

}


- (IBAction)getLocation:(UIBarButtonItem *)sender {
    //socialmediapostviewcontroller is the delegate and will receive all location updates
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager requestWhenInUseAuthorization];
    //startUpdatingLocation method called
    [locationManager startUpdatingLocation];
}



#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //NSLog(@"%@", [locations lastObject]);
    
    
    //NSString *address;
    //currentLocation = [locations objectAtIndex:0];
    currentLocation = [locations lastObject];
    [locationManager stopUpdatingLocation];
    NSLog(@"%@", currentLocation);
    // Reverse Geocoding
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
             
             //NSLog(@"placemark %@",placemark);
             //NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             //NSString *Address = [[NSString alloc]initWithString:locatedAt];
             // NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             // NSString *Country = [[NSString alloc]initWithString:placemark.country];
             // NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
             //NSLog(@"%@",CountryArea);
             
             address = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                        placemark.subThoroughfare, placemark.thoroughfare,
                        placemark.locality,
                        placemark.administrativeArea,placemark.postalCode,
                        placemark.country];
             //NSLog(@"%@",locatedAt);
             //NSLog(@"%@",Address);
             //NSLog(@"%@",Area);
             //NSLog(@"%@",Country);
             // NSLog(@"%@",CountryArea);
             NSLog(@"%@",address);
             self.postText.text = address;
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             //return;
             //NSString *CountryArea = NULL;
         }
         
     }];
    
}


@end
