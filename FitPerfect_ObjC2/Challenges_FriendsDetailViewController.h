//
//  Challenges_FriendsDetailViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/16/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Challenges_FriendsDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *ChallengesFriendsTableView;
@property(nonatomic,strong) NSString *challenges_friendsDetail;
@property(nonatomic,strong) NSString *challengeName;
- (IBAction)StartChallengeAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *startChallengeBtn;

@property (nonatomic,strong) NSArray *challengeFriends;
@property (strong, nonatomic) IBOutlet UIButton *showFriendsBtn;
@property (strong, nonatomic) IBOutlet UIButton *startCommunityChallengeBtn;

- (IBAction)reloadFriends:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *createCommunityChalengeTF;
@property (strong, nonatomic) IBOutlet UIButton *createCommunityChallengeBtn;
- (IBAction)createNewCommunityChallenge:(UIButton *)sender;

- (IBAction)startCommunityChallenge:(UIButton *)sender;


@end
