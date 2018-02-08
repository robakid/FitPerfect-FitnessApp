//
//  ProfileViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/3/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *FullNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *EmailLbl;
@property (strong, nonatomic) IBOutlet UILabel *MemberSinceLbl;
@property (strong, nonatomic) IBOutlet UITableView *profileChallengesTable;
- (IBAction)getCurrentChallenges:(UIButton *)sender;

@end
