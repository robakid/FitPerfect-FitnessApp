//
//  Challenges_FriendsDetailViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 11/16/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "Challenges_FriendsDetailViewController.h"
//#import "ChallengesDetailViewController.h"
#import "DataModel.h"

@interface Challenges_FriendsDetailViewController ()

@end

@implementation Challenges_FriendsDetailViewController{
    //NSArray *challengeFriends;
    NSMutableArray *friendsSelected;
    DataModel *data;
    NSMutableArray *selectedRows;
    NSString *participant1;
    
    NSString *participant2;
    NSString *participant3;
    NSString *participant4;
    NSString *participant5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    data = [[DataModel alloc]init];
    [data returnUsersFriends:[[NSUserDefaults standardUserDefaults]valueForKey:@"email"]];
    selectedRows = [NSMutableArray array];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"FitPerfect_header.jpg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    friendsSelected = [[NSMutableArray alloc] init];
    if ([_challenges_friendsDetail isEqualToString:@"Steps"] || [_challenges_friendsDetail isEqualToString:@"Floors Climbed"] || [_challenges_friendsDetail isEqualToString:@"Calories Burned"]) {
        //challengeFriends = [NSArray arrayWithObjects:@"Ana",@"Jane", nil];
        self.challengeFriends = data.friends;

    }
    else if([_challenges_friendsDetail isEqualToString:@"New Challenge"]){
        self.ChallengesFriendsTableView.hidden=YES;
        self.showFriendsBtn.hidden=YES;
        self.startCommunityChallengeBtn.hidden=YES;
        self.createCommunityChallengeBtn.hidden=NO;
        self.createCommunityChalengeTF.hidden=NO;
        
    }
    else{
        self.ChallengesFriendsTableView.hidden=YES;
        self.showFriendsBtn.hidden=YES;
        self.startCommunityChallengeBtn.hidden=NO;
    }

    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_challenges_friendsDetail isEqualToString:@"Steps"] || [_challenges_friendsDetail isEqualToString:@"Floors Climbed"] || [_challenges_friendsDetail isEqualToString:@"Calories Burned"]) {
        return [self.challengeFriends count];
    }
    return 0;
}

//called every time when a table row is displayed.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Challenges_FriendsDetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if ([_challenges_friendsDetail isEqualToString:@"Steps"] || [_challenges_friendsDetail isEqualToString:@"Floors Climbed"] || [_challenges_friendsDetail isEqualToString:@"Calories Burned"]) {
        cell.textLabel.text = [self.challengeFriends objectAtIndex:indexPath.row];
    }

    return cell;
}

//when a row is selected:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //**displaying a check mark when a row is selected
    
    //retrieves the selected table cell by using the indexPath.
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *friendEmail;
    if([selectedRows containsObject:indexPath]){
        //deselect selected row and remove from friendsSelected
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [selectedRows removeObject:indexPath];
        friendEmail = cell.textLabel.text;
        [friendsSelected removeObject:friendEmail];
        //friendEmail = cell.textLabel.text;
    }
    else{
        //select a row and add to friendsSelected
        [selectedRows addObject:indexPath];
        friendEmail = cell.textLabel.text;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [friendsSelected addObject:friendEmail];
    }

    self.startChallengeBtn.hidden = NO;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)StartChallengeAction:(UIButton *)sender {
    //1. get challenge name and type selected and all emails of users in challenge
    //ChallengesDetailViewController
    NSString *challengeName = [_challengeName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];//ex) 1 hour
    NSString *challengeType = [_challenges_friendsDetail stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; //ex) steps
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [DateFormatter stringFromDate:[NSDate date]];
    
    //first participant is user
    participant1=[[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    [data collectAllDashboardEntriesForUserAndDate:participant1 secondParam:date];
    
    participant2=@"null";
    participant3 = @"null";
    participant4 =@"null";
    participant5 = @"null";
    int count = [friendsSelected count];
    //if email exists, put as participant
    if (count >= 1) {
        participant2=friendsSelected[0];
        [data collectAllDashboardEntriesForChallengePartipant2AndDate:participant2 secondParam:date];
    }
    if (count >=2) {
        participant3=friendsSelected[1];
        [data collectAllDashboardEntriesForChallengePartipant3AndDate:participant3 secondParam:date];
    }
    if (count >=3) {
        participant4=friendsSelected[2];
        [data collectAllDashboardEntriesForChallengePartipant4AndDate:participant4 secondParam:date];
    }
    if (count >= 4) {
        participant5=friendsSelected[3];
        [data collectAllDashboardEntriesForChallengePartipant5AndDate:participant5 secondParam:date];
    }
    
    
    
    //2. add info (challenge name, type, and emails) to database
    
    [data addUserInitiatedChallenge:challengeName secondParm:challengeType thirdParam:0 fourthParam:participant1 fifthParam:participant2 sixthParam:participant3 seventhParam:participant4 eighthParam:participant5 ninthParam:@"null"];
    
    //3. set timer to stop at end of challenge and give results by calling onTick method: for 24 hour challenge: 86400 seconds in a day; for 1 hour challenge: 3600 seconds; for testing, set to 60 seconds
    [self performSelector:@selector(onTick:) withObject:nil afterDelay:60.0];
    
    //4. use local notifications to alert user that challenge has finished
    // Register the local notifications with Settings
    //prompt the user to allow notifications and then register the settings. In this case we asking the user for permission to display an alert, add badge to the app and play a sound when a notification is fired off. We do this by creating a UIUserNotificationType object and adding which types we want to ask permission for. Then we use those types to create a UIUserNotificationSettings object, and finally we register the settings
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    //First we create the UILocalNotification object, then we set the parameters using the UIElements we added to our view
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification)
    {
        //will fire in 60 seconds from current date and time
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
        //time zone set to default
        notification.timeZone = [NSTimeZone defaultTimeZone];
        //when notification is available, it will show a 1; default is 0
        notification.applicationIconBadgeNumber = 1;
        //will play a default sound when notification is available
        notification.soundName = UILocalNotificationDefaultSoundName;
        //setting alert body test which will appear in notification
        notification.alertBody = @"Challenge Complete! Check results on profile page.";
    }
    
    // this will schedule the notification to fire at the fire date
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    // this will fire the notification right away, it will still also fire at the date we set
    //[[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
    // we're creating a string of the date so we can log the time the notif is supposed to fire
    //used for testing purposes
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-yyy hh:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
    NSString *notifDate = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60]];
    NSLog(@"%s: fire time = %@", __PRETTY_FUNCTION__, notifDate);
    
    [data collectAllChallengesInfo];

}
//onTick called when timer goes off
-(void)onTick:(NSTimer *)timer {
    //find out who has most steps
    //get their email and store in database
    NSLog(@"60 second Timer finished");
    //get participants results and add winner to database
        //1. call steps for each partipant
    int usersSteps = [data.steps intValue];
    int partipant2Steps = [data.partipant2steps intValue];
    int partipant3Steps = [data.partipant3steps intValue];
    int partipant4Steps = [data.partipant4steps intValue];
    int partipant5Steps = [data.partipant5steps intValue];
    NSArray *numbers = [NSArray arrayWithObjects:
                        [NSNumber numberWithInt:usersSteps],[NSNumber numberWithInt:partipant2Steps], [NSNumber numberWithInt:partipant3Steps],[NSNumber numberWithInt:partipant4Steps], [NSNumber numberWithInt:partipant5Steps], nil];

        //2. compare steps to see which is greater
    int max = [[numbers valueForKeyPath:@"@max.intValue"] intValue];
        //3. add winner to database
    int challengeID = data.currentChallengeID;
    if (usersSteps == max) {
        [data updateChallengeToAddWinner:challengeID secondParam:participant1];

    }
    if (partipant2Steps == max) {
        [data updateChallengeToAddWinner:challengeID secondParam:participant2];
        
    }
    if (partipant3Steps == max) {
        [data updateChallengeToAddWinner:challengeID secondParam:participant3];
        
    }
    if (partipant4Steps == max) {
        [data updateChallengeToAddWinner:challengeID secondParam:participant4];
        
    }
    if (partipant5Steps == max) {
        [data updateChallengeToAddWinner:challengeID secondParam:participant5];
        
    }

    
    
    
}

- (IBAction)reloadFriends:(UIButton *)sender {
    self.challengeFriends = data.friends;
    [self.ChallengesFriendsTableView reloadData];
}

- (IBAction)createNewCommunityChallenge:(UIButton *)sender {
    NSString *communityChallengeName = [self.createCommunityChalengeTF.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [data startCommunityChallenge:communityChallengeName];
    
}

- (IBAction)startCommunityChallenge:(UIButton *)sender {
    NSString *userEmail = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    NSString *communityChallengeName = [_challenges_friendsDetail stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [data addUserToCommunityChallenge:userEmail secondParam:communityChallengeName];
    
}
@end
