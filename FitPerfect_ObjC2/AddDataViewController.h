//
//  AddDataViewController.h
//  FitPerfect
//
//  Created by Janina Grayson on 12/8/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDataViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *stepsTF;

@property (strong, nonatomic) IBOutlet UITextField *milesTF;

@property (strong, nonatomic) IBOutlet UITextField *calBurnTF;

@property (strong, nonatomic) IBOutlet UITextField *floorsTF;

@property (strong, nonatomic) IBOutlet UITextField *heartTF;
@property (strong, nonatomic) IBOutlet UITextField *activeMinutesTF;
@property (strong, nonatomic) IBOutlet UITextField *calIntakeTF;

- (IBAction)addData:(UIButton *)sender;






@end
