//
//  SocialTableViewCell.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 12/8/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *firstNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *activityLbl;
@property (strong, nonatomic) IBOutlet UILabel *postLbl;

@end
