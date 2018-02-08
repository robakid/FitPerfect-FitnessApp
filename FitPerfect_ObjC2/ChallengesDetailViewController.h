//
//  ChallengesDetailViewController.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/16/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallengesDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *ChallengesDetailTableView;
@property(nonatomic,strong) NSString *challengesDetail;

@property (strong, nonatomic) IBOutlet UIButton *showCommunityChallengesBtn;

- (IBAction)showCommunityChallenges:(UIButton *)sender;



@end
