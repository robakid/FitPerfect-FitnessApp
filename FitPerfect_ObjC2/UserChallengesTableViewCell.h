//
//  UserChallengesTableViewCell.h
//  FitPerfect
//
//  Created by Janina Grayson on 12/9/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserChallengesTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *challengeName;
@property (strong, nonatomic) IBOutlet UILabel *challengeActivity;

@property (strong, nonatomic) IBOutlet UILabel *challengeWinner;

@end
