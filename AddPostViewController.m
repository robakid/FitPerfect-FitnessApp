//
//  AddPostViewController.m
//  FitPerfect
//
//  Created by Ana Robakidze on 12/12/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "AddPostViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AddPostViewController ()


@end

@implementation AddPostViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
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

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (IBAction)takePicture:(id)sender
{   UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
}








@end
