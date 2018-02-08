//
//  SocialMediaPostViewController.h
//  FitPerfect
//
//  Created by Ana Robakidze on 12/13/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SocialMediaPostViewController : UIViewController<CLLocationManagerDelegate>

- (IBAction)Cancel:(id)sender;

- (IBAction)TakePicture:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *FName;
@property (weak, nonatomic) IBOutlet UITextField *LName;
@property (weak, nonatomic) IBOutlet UITextField *Activity;
@property (strong, nonatomic) IBOutlet UITextView *postText;
- (IBAction)getLocation:(UIBarButtonItem *)sender;
- (IBAction)PostToNewsfeed:(UIButton *)sender;


@end
