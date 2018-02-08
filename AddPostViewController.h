//
//  AddPostViewController.h
//  FitPerfect
//
//  Created by Ana Robakidze on 12/12/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddPostViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *FName;



- (IBAction)cancel:(id)sender;

- (IBAction)takePicture:(id)sender;


@end
