//
//  DataModel.h
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 12/7/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

extern NSString* const BaseURLString;
@property(strong) NSDictionary *dataDict;
@property(strong) NSDictionary *socialDict;
@property(strong) NSDictionary *challengeDict;
@property(strong) NSDictionary *userChallengesDict;
@property (nonatomic,strong) NSString *message;

@property (nonatomic) int userCount;
@property (nonatomic) int postCount;
@property (nonatomic) int challengesCount;
@property (nonatomic) int lastLoginCount;
@property (nonatomic) int userPostCount;

@property (nonatomic,strong) NSString *challengeName;
@property (nonatomic,strong) NSString *challengeAT;
@property (nonatomic,strong) NSString *challengeWinner;

@property (nonatomic,strong) NSString *stepsGoal;
@property (nonatomic,strong) NSString *calBurnGoal;
@property (nonatomic,strong) NSString *floorsGoal;
@property (nonatomic,strong) NSString *activeMinutesGoal;


@property (nonatomic,strong) NSMutableArray *firstName;
@property (nonatomic,strong) NSMutableArray *lastName;
@property (nonatomic,strong) NSMutableArray *userEmail;

@property (nonatomic,strong) NSMutableArray *currentCommunityChallenges;

@property (nonatomic,strong) NSMutableArray *friends;

@property (nonatomic,strong) NSString *managementAdminName;
@property (nonatomic,strong) NSString *managementAdminPassword;
@property (nonatomic,strong) NSString *managementAdminSince;

@property (nonatomic,strong) NSString *managementManagerName;
@property (nonatomic,strong) NSString *managementManagerPassword;
@property (nonatomic,strong) NSString *managementManagerSince;

@property (nonatomic,strong) NSString *steps;
@property (nonatomic,strong) NSString *calBurn;
@property (nonatomic,strong) NSString *floors;
@property (nonatomic,strong) NSString *active;
@property (nonatomic,strong) NSString *heart;
@property (nonatomic,strong) NSString *calIntake;
@property (nonatomic,strong) NSString *miles;

@property (nonatomic) int stepsYesterday;
@property (nonatomic) int calBurnYesterday;

@property (nonatomic) int steps2DaysAgo;
@property (nonatomic) int calBurn2DaysAgo;

@property (nonatomic) int steps3DaysAgo;
@property (nonatomic) int calBurn3DaysAgo;

@property (nonatomic) int steps4DaysAgo;
@property (nonatomic) int calBurn4DaysAgo;

@property (nonatomic) int steps5DaysAgo;
@property (nonatomic) int calBurn5DaysAgo;

@property (nonatomic) int steps6DaysAgo;
@property (nonatomic) int calBurn6DaysAgo;

@property (nonatomic) int currentChallengeID;

@property (nonatomic,strong) NSString *partipant2steps;
@property (nonatomic,strong) NSString *partipant3steps;
@property (nonatomic,strong) NSString *partipant4steps;
@property (nonatomic,strong) NSString *partipant5steps;

@property (nonatomic,strong) NSArray *social;
@property (nonatomic,strong) NSMutableArray *postID;
@property (nonatomic,strong) NSMutableArray *postPhoto;
@property (nonatomic,strong) NSMutableArray *activity;
@property (nonatomic,strong) NSMutableArray *firstN;
@property (nonatomic,strong) NSMutableArray *lastN;
@property (nonatomic,strong) NSMutableArray *postVideo;
@property (nonatomic,strong) NSMutableArray *email;
@property (nonatomic,strong) NSMutableArray *postText;

//returns the number of users in userAccounts table
-(int) getTotalNumberOfUsers;
//calculates the number of users and returns all rows in user accounts table
-(void) calculateNumberOfUsers;

//adds user sign up info to user accounts table
-(void) signUpUser: (NSString *) firstN secondParm:(NSString *) lastN thirdParam:(NSString *) email fourthParam:(NSString *) age;

//adds or updates user goals to user accounts table
-(void) updateUserGoals: (NSString *) stepsGoal secondParm:(NSString *) calBurnGoal thirdParam:(NSString *) floorsGoal fourthParam:(NSString *) activeMinutesGoal fifthParam: (NSString *) email;

//adds or updates device type to user accounts table
-(void) updateDeviceType: (NSString *) email secondParm:(NSString *) deviceType;

//adds or updates number of challenges user completed in user accounts table
-(void) updateChallengesCompleted: (NSString *) email secondParm:(int) numChallengesCompleted;

//adds or updates number of challenges user won in user accounts table
-(void) updateChallengesWon: (NSString *) email secondParm:(int) numChallengesWon;

//adds or updates boolean value for location enabled in user accounts table; enableLocationBoolean= 1 (yes) or 0 (no)
-(void) updateLocationEnabledBoolean: (NSString *) email secondParm:(int) enableLocationBoolean;

//add a challenge to challenges table; Challenge_Custom = 1 or 0; if no email put "null"
-(void) addUserInitiatedChallenge: (NSString *) Challenge_NAME secondParm:(NSString *) Challenge_Activity_Type thirdParam:(int) Challenge_Custom fourthParam:(NSString *) Challenge_Participant_Email_1 fifthParam: (NSString *) Challenge_Participant_Email_2 sixthParam: (NSString *) Challenge_Participant_Email_3 seventhParam: (NSString *) Challenge_Participant_Email_4 eighthParam: (NSString *) Challenge_Participant_Email_5 ninthParam: (NSString *) Challenge_WINNER_Email;

//update challenge to add winner
-(void) updateChallengeToAddWinner: (int)challengeID secondParam: (NSString *)winner;

//add to dashboard based on email
-(void) addToDashboard:(NSString *) email secondParm:(NSString *) steps thirdParam:(NSString *) miles fourthParam:(NSString *) caloriesBurned fifthParam: (NSString *) floorsCLimbed sixthParam: (NSString *) BMP seventhParam: (NSString *) activeMinutes eighthParam: (NSString *) calorieIntake;


//creates arrays for rows in social table for newsfeed screen
-(void)CreateSocialTable;

//returns a dictionary of info for social table
-(NSDictionary *)returnSocialArray;

//returns numbers of Posts
-(int) getNumberOfPosts;

//add to social table; post video is null; post video is null
-(void) addToSocialTable:(NSString *) email secondParm:(NSString *) FirstName thirdParam:(NSString *) LastName fourthParam:(NSString *) POST_TEXT fifthParam: (NSString *) ACTIVITY_TYPE;

//update post text in social table based on post ID
-(void)updateSocialPostText: (int)postID secondParam: (NSString *)postText;

//delete a entry in social table
-(void)deleteSocialPost: (int)postID;

//delete user in user accounts table
-(void)deleteUser: (NSString *)email;

//creates a challenge dictionary
-(void)collectAllChallengesInfo;

//returns number of challenges in table
-(int) getNumberOfChallenges;

//Starts a community challenge by adding it to the challenges database without any email addresses; challenge_name is community and challenge_activity_type is the name that you call the community challenge
-(void) startCommunityChallenge: (NSString *)communityChallengeName;

//Delete a community challenges that are finished
-(void) deleteCompletedCommmunityChallenge: (NSString *)communityChallengeName;

//adding yourself to a community challenge (can only add one user for now to 5th participant position)
-(void) addUserToCommunityChallenge: (NSString *)email secondParam: (NSString *)communityChallengeName;

//Return all rows in management table based on managementType
//
//managementType is the "email" of manager1 or admin1"
-(void)collectAllRowsInManagementBasedOnTypeForAdmin: (NSString *)managementType;

-(void)collectAllRowsInManagementBasedOnTypeForManager: (NSString *)managementType;

//sidsachdev.com/webservices/get_allusersemail?Email=jcg48@cornell.edu
-(void)collectUserAccountInfoForUser: (NSString *)email;

-(NSString *)getStepsGoal;

-(NSString *)getCalBurnedGoal;

-(NSString *)getFloorsGoal;

-(NSString *)getActiveMinutesGoal;


//Update lastLogin field in user accounts table (occurs during login)
-(void) updateLastLogin: (NSString *)email;

//returns all email addresses of users who logged in yesterday or today
-(void) collectLastLoggedInUsers;

//get last logged in count
-(int) getLastLoggedInCount;

//collects all dashboard rows for a user
-(void)collectAllDashboardEntriesForUser: (NSString *)email;

//collect all rows in social table based on email; use for search in social table
-(void)collectAllSocialBasedOnEmail: (NSString *)email;

//get number of user posts
-(int) getUserPostCount;

-(void)collectAllDashboardEntriesForChallengePartipant2AndDate: (NSString *)email secondParam: (NSString *)date;
-(void)collectAllDashboardEntriesForChallengePartipant3AndDate: (NSString *)email secondParam: (NSString *)date;
-(void)collectAllDashboardEntriesForChallengePartipant4AndDate: (NSString *)email secondParam: (NSString *)date;
-(void)collectAllDashboardEntriesForChallengePartipant5AndDate: (NSString *)email secondParam: (NSString *)date;

//collects all dashboard rows for a user: using today's date
-(void)collectAllDashboardEntriesForUserAndDate: (NSString *)email secondParam: (NSString *)date;

//collects all steps and calories burned for yesterday
-(void)collectAllDashboardEntriesForUserAndYesterdayDate: (NSString *)email;

-(void)collectAllDashboardEntriesForUserAnd2DaysPastDate: (NSString *)email;

-(void)collectAllDashboardEntriesForUserAnd3DaysPastDate: (NSString *)email;

-(void)collectAllDashboardEntriesForUserAnd4DaysPastDate: (NSString *)email;

-(void)collectAllDashboardEntriesForUserAnd5DaysPastDate: (NSString *)email;

-(void)collectAllDashboardEntriesForUserAnd6DaysPastDate: (NSString *)email;

//return a user's friends
-(void)returnUsersFriends: (NSString *)email;


//add a friendEmail to the Friends table based on userEmail (not using for this: and then return all of a user's friends)
-(void)addFriend: (NSString *)userEmail secondParam: (NSString *)friendEmail;

//return from the challenges table a challenge_name, challenge_activity_type, and a challenge winner based on any one of the 5 participant email addresses
-(void)collectChallengeInfoBasedOnParticipant:(NSString *)email;


//delete a row in Community Challenge table based on name field
-(void)deleteCommunityChallegefromCommunityChallengeTable: (NSString *)challengeName;


//update a row in Community Challenge table based on name field
-(void)updateCommunityChallegefromCommunityChallengeTable: (NSString *)challengeName secondParam: (NSString *)challengeDescription;



//add a row in Community Challenge table
-(void)addCommunityChallegefromCommunityChallengeTable: (NSString *)challengeName secondParam: (NSString *)challengeDescription;



//return row in Community Challenge table based on name field
-(void)collectCommunityChallegefromCommunityChallengeTable: (NSString *)challengeName;

//return all rows where challenge name is community in challenges table
-(void)getCurrentCommunityChallenges;



@end
