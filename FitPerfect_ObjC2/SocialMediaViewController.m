//
//  SocialMediaViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/28/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "SocialMediaViewController.h"
#import "DataModel.h"
#import "SocialTableViewCell.h"

@implementation SocialMediaViewController{
    //provides location data
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    CLLocation *currentLocation;
    NSString *address;
    NSMutableArray *firstName;
    NSMutableArray *lastName;
    NSMutableArray *post;
    NSMutableArray *activity;
    DataModel *data;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    data =[[DataModel alloc]init];
    
    [data CreateSocialTable];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getSocialDataFromDictionary
{
    NSDictionary *social;
    
    
    social = [data returnSocialArray];
    
    //NSDictionary *social = [data returnSocialArray];
    NSArray *socialFields = [NSArray arrayWithObjects:@"PostID",
                             @"POST_PHOTO", @"ACTIVITY_TYPE", @"FirstName",@"LastName", @"POST_VIDEO", @"DATE_POSTED", @"Email",@"POST_TEXT",@"user_location",nil];
    NSMutableArray *postID = [NSMutableArray array];
    NSMutableArray *postPhoto = [NSMutableArray array];
    activity = [NSMutableArray array];
    firstName = [NSMutableArray array];
    lastName = [NSMutableArray array];
    NSMutableArray *postVideo = [NSMutableArray array];
    NSMutableArray *email = [NSMutableArray array];
    post = [NSMutableArray array];
    NSMutableArray *location = [NSMutableArray array];
    for (id pair in social) {
        //NSLog(@"%@: %@", usersDict[key], key);
        NSLog(@"%@", pair);
        for (id k in pair){
            //NSLog(@"%@", k);//field
            //[fields addObject:k];
            NSLog(@"%@", pair[k]);//value
            if ([k isEqualToString:socialFields[0]]) {
                [postID addObject:pair[k]];
            }
            if ([k isEqualToString:socialFields[1]]) {
                //if ([pair[k] isEqualToString: @"null"]) {
                //    [postPhoto addObject:@"empty"];
                //}
                [postPhoto addObject:pair[k]];
            }
            if ([k isEqualToString:socialFields[2]]) {
                [activity addObject:pair[k]];
            }
            if ([k isEqualToString:socialFields[3]]) {
                [firstName addObject:pair[k]];
            }
            if ([k isEqualToString:socialFields[4]]) {
                [lastName addObject:pair[k]];
            }
            if ([k isEqualToString:socialFields[5]]) {
                //if ([pair[k] isEqualToString: @"null"]) {
                //    [postVideo addObject:@"empty"];
                //}
                [postVideo addObject:pair[k]];
            }
            if ([k isEqualToString:socialFields[6]]) {
                [email addObject:pair[k]];
            }
            if ([k isEqualToString:socialFields[8]]) {
                [post addObject:pair[k]];
            }
            if ([k isEqualToString:socialFields[9]]) {
                if ([pair[k] isEqual:[NSNull null]]) {
                    [location addObject:@" "];
                }
                else{
                    [location addObject:pair[k]];
                }
                
            }
            
        }
    }
    [self.socialTableView reloadData];
    
}

- (IBAction)GetLocationAction:(UIButton *)sender {
    //socialmediaviewcontroller is the delegate and will receive all location updates
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [firstName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SocialCell";
    
    SocialTableViewCell *cell = (SocialTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SocialCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.firstNameLbl.text = [firstName objectAtIndex:indexPath.row];
    cell.lastNameLbl.text = [lastName objectAtIndex:indexPath.row];
    cell.postLbl.text = [post objectAtIndex:indexPath.row];
    cell.activityLbl.text = [activity objectAtIndex:indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}





- (IBAction)getData:(UIBarButtonItem *)sender {
     [self getSocialDataFromDictionary];
}
@end
