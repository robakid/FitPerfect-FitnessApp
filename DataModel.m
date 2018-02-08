//
//  DataModel.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 12/7/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "DataModel.h"
#import "AFNetworking.h"
#import "Challenges_FriendsDetailViewController.h"

//url string to access webservices
NSString* const BaseURLString = @"---";//add web server address here

@implementation DataModel{
    
}


-(void) calculateNumberOfUsers
{
    __block int numberOfUsers;
    //1.
    //complete url string with function name appended
    NSString *string = [NSString stringWithFormat:@"%@get_allusers", BaseURLString];
    //string used to create NSURL object
    NSURL *url = [NSURL URLWithString:string];
    //NSURL object used to create NSURLRequest object
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //2.
    //created an AFHTTPRequestOperation object to handle HTTP transfers across network using NSURLRequest object
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //setting responseSerializer property to to get JSON response
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //3.
        //if request succeeds, JSON serailizer parses received data and returns a dictionary
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *usersDict = [self.dataDict objectForKey:@"msg"];
        numberOfUsers = [usersDict count];
        self.message = @"All data from user accounts table retrieved";
        NSLog(@"%@",self.message);
        self.userCount = numberOfUsers;
        self.firstName = [NSMutableArray array];
        self.lastName = [NSMutableArray array];
        self.userEmail = [NSMutableArray array];
        //NSDictionary *usersDict = [self.dataDict objectForKey:@"msg"];
        for (id pair in usersDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);//value
                if ([key isEqualToString:@"firstname"]) {

                    [self.firstName addObject:pair[key]];
                }
                if ([key isEqualToString:@"lastname"]) {

                    [self.lastName addObject:pair[key]];
                }
                if ([key isEqualToString:@"email"]) {

                    [self.userEmail addObject:pair[key]];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 4.
        //if request fails,
        NSLog(@"Error Retreiving Data: %@",error);
        
    }];
    
    // 5. starts AFHTTPRequestOperation operation
    [operation start];
    
}

-(int) getTotalNumberOfUsers
{
    return self.userCount;
    
}

-(void) signUpUser: (NSString *) firstN secondParm:(NSString *) lastN thirdParam:(NSString *) email fourthParam:(NSString *) age
{
    NSString *string = [NSString stringWithFormat:@"%@signup?FirstName=%@&LastName=%@&Email=%@&Age=%@", BaseURLString,firstN,lastN,email,age];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"SignUp Data sent to Database";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
    
}

-(void) updateUserGoals: (NSString *) stepsGoal secondParm:(NSString *) calBurnGoal thirdParam:(NSString *) floorsGoal fourthParam:(NSString *) activeMinutesGoal fifthParam: (NSString *) email
{
    
    NSString *string = [NSString stringWithFormat:@"%@update_account?Email=%@&GOAL_STEPS=%@&GOAL_CaloriesToBurn=%@&GOAL_Floors=%@&GOAL_ActiveMinutes=%@", BaseURLString,email,stepsGoal,calBurnGoal,floorsGoal,activeMinutesGoal];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"User Goals sent to Database";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void) updateDeviceType: (NSString *) email secondParm:(NSString *) deviceType
{
    NSString *string = [NSString stringWithFormat:@"%@update_devicetype_account?Email=%@&Device_Type=%@", BaseURLString,email,deviceType];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"User Device Type sent to Database";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void) updateChallengesCompleted: (NSString *) email secondParm:(int) numChallengesCompleted
{
    NSString *string = [NSString stringWithFormat:@"%@update_challenge_comp_account?Email=%@&Challenges_Completed=%i", BaseURLString,email,numChallengesCompleted];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Update of Number of User Challenges Completed sent to Database";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void) updateChallengesWon: (NSString *) email secondParm:(int) numChallengesWon
{
    NSString *string = [NSString stringWithFormat:@"%@update_challenge_won_account?Email=%@&Challenges_WON=%i", BaseURLString,email,numChallengesWon];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Update of Number of User Challenges Won sent to Database";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void) updateLocationEnabledBoolean: (NSString *) email secondParm:(int) enableLocationBoolean
{
    NSString *string = [NSString stringWithFormat:@"%@update_location_enable_account?Email=%@&Location_Enabled=%i", BaseURLString,email,enableLocationBoolean];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Update Enable Location Boolean value sent to Database";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void) addUserInitiatedChallenge: (NSString *) Challenge_NAME secondParm:(NSString *) Challenge_Activity_Type thirdParam:(int) Challenge_Custom fourthParam:(NSString *) Challenge_Participant_Email_1 fifthParam: (NSString *) Challenge_Participant_Email_2 sixthParam: (NSString *) Challenge_Participant_Email_3 seventhParam: (NSString *) Challenge_Participant_Email_4 eighthParam: (NSString *) Challenge_Participant_Email_5 ninthParam: (NSString *) Challenge_WINNER_Email
{
    NSString *string = [NSString stringWithFormat:@"%@add_challenges?Challenge_NAME=%@&Challenge_Activity_Type=%@&Challenge_Custom=%i&Challenge_Participant_Email_1=%@&Challenge_Participant_Email_2=%@&Challenge_Participant_Email_3=%@&Challenge_Participant_Email_4=%@&Challenge_Participant_Email_5=%@&Challenge_WINNER_Email=%@", BaseURLString,Challenge_NAME,Challenge_Activity_Type,Challenge_Custom,Challenge_Participant_Email_1,Challenge_Participant_Email_2,Challenge_Participant_Email_3,Challenge_Participant_Email_4,Challenge_Participant_Email_5,Challenge_WINNER_Email];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Added User initated challenge to Database";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void) updateChallengeToAddWinner: (int)challengeID secondParam: (NSString *)winner
{
    NSString *string = [NSString stringWithFormat:@"%@update_challange_winner?ChallengeID=%i&Challenge_WINNER_Email=%@", BaseURLString,challengeID,winner];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Added challenge winner to Database";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}


-(void) addToDashboard:(NSString *) email secondParm:(NSString *) steps thirdParam:(NSString *) miles fourthParam:(NSString *) caloriesBurned fifthParam: (NSString *) floorsCLimbed sixthParam: (NSString *) BMP seventhParam: (NSString *) activeMinutes eighthParam: (NSString *) calorieIntake
{
    
    NSString *string = [NSString stringWithFormat:@"%@add_dashboard?Email=%@&Steps=%@&Miles=%@&CaloriesBurned=%@&FloorsClimbed=%@&BMP_Resting=%@&ActiveMinutes=%@&CalorieIntake=%@", BaseURLString,email,steps,miles,caloriesBurned,floorsCLimbed,BMP,activeMinutes,calorieIntake];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Added info to Dashboard table in Database";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)CreateSocialTable
{
    __block int numberOfPosts;
    
    NSString *string = [NSString stringWithFormat:@"%@get_social", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *usersDict = [self.dataDict objectForKey:@"msg"];
        numberOfPosts = [usersDict count];
        self.message = @"All data from social table retrieved";
        NSLog(@"%@",self.message);
        self.postCount = numberOfPosts;
        self.socialDict = usersDict;

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error Retreiving Data: %@",error);
        
    }];
    
    [operation start];
}

-(NSDictionary *)returnSocialArray
{
    return self.socialDict;
}

-(int) getNumberOfPosts
{
    return self.postCount;;
    
}

-(void) addToSocialTable:(NSString *) email secondParm:(NSString *) FirstName thirdParam:(NSString *) LastName fourthParam:(NSString *) POST_TEXT fifthParam: (NSString *) ACTIVITY_TYPE
{
    NSString *string = [NSString stringWithFormat:@"%@add_social?Email=%@&FirstName=%@&LastName=%@&POST_TEXT=%@&POST_PHOTO=null&POST_VIDEO=null&ACTIVITY_TYPE=%@", BaseURLString,email,FirstName,LastName,POST_TEXT,ACTIVITY_TYPE];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Added post to social table in Database";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)updateSocialPostText: (int)postID secondParam: (NSString *)postText
{
    NSString *string = [NSString stringWithFormat:@"%@update_social?PostID=%i&POST_TEXT=%@", BaseURLString,postID,postText];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Updated post text for a post in social table";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)deleteSocialPost: (int)postID
{
    NSString *string = [NSString stringWithFormat:@"%@delete_socialmedia?PostID=%i", BaseURLString,postID];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Post deleted";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)deleteUser: (NSString *)email
{
    NSString *string = [NSString stringWithFormat:@"%@delete_user?Email=%@", BaseURLString,email];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"User deleted";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)collectAllChallengesInfo
{
    __block int numberOfChallenges;
    NSString *string = [NSString stringWithFormat:@"%@get_challengeinfo", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *usersDict = [self.dataDict objectForKey:@"msg"];
        numberOfChallenges = [usersDict count];
        self.challengesCount = numberOfChallenges;
        self.challengeDict = usersDict;
        self.message = @"All data from challenges table retreived";
        NSLog(@"%@",self.message);
        //NSDictionary *usersDict = [self.dataDict objectForKey:@"msg"];
        for (id pair in self.challengeDict) {
            //NSLog(@"%@: %@", usersDict[key], key);
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);//value
                if ([key isEqualToString:@"ChallengeID"]) {
                    int value = [pair[key] intValue];
                    if (value > self.currentChallengeID) {
                        self.currentChallengeID = value;
                    }
                }

            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(int) getNumberOfChallenges
{
    return self.challengesCount;
}

-(void) startCommunityChallenge: (NSString *)communityChallengeName
{
    NSString *string = [NSString stringWithFormat:@"%@add_challenges_name?Challenge_NAME=Community&Challenge_Activity_Type=%@", BaseURLString,communityChallengeName];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Community Challenge Started";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void) deleteCompletedCommmunityChallenge: (NSString *)communityChallengeName
{
    NSString *string = [NSString stringWithFormat:@"%@delete_challenges?Challenge_Activity_Type=%@", BaseURLString,communityChallengeName];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Community Challenge Finished";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void) addUserToCommunityChallenge: (NSString *)email secondParam: (NSString *)communityChallengeName
{
    
    NSString *string = [NSString stringWithFormat:@"%@update_another_parti?Challenge_Activity_Type=%@&Challenge_Participant_Email_1=%@&Challenge_Participant_Email_2=sidd2@gmail.com&Challenge_Participant_Email_3=siddd3@gmail.com&Challenge_Participant_Email_4=sidddddd4@gmail.com&Challenge_Participant_Email_5=new@test.com", BaseURLString,communityChallengeName,email];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"User added to Community Challenge";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

//managementType is the "email" of the manager or admin"
-(void)collectAllRowsInManagementBasedOnTypeForAdmin: (NSString *)managementType
{
    
    NSString *string = [NSString stringWithFormat:@"%@get_allmanagementtype?ManagementType=%@", BaseURLString,managementType];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *usersDict = [self.dataDict objectForKey:@"msg"];
        for (id pair in usersDict) {
            //NSLog(@"%@: %@", usersDict[key], key);
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);//value
                if ([key isEqualToString:@"managementtype"]) {
                    self.managementAdminName=pair[key];
                }
                if ([key isEqualToString:@"management_password"]) {
                    self.managementAdminPassword=pair[key];
                }
                if ([key isEqualToString:@"management_since"]) {
                    self.managementAdminSince=pair[key];
                }
            }
        }
        self.message = @"Management Data retreived";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)collectAllRowsInManagementBasedOnTypeForManager: (NSString *)managementType
{
    NSString *string = [NSString stringWithFormat:@"%@get_allmanagementtype?ManagementType=%@", BaseURLString,managementType];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *usersDict = [self.dataDict objectForKey:@"msg"];
        for (id pair in usersDict) {
            //NSLog(@"%@: %@", usersDict[key], key);
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);//value

                if ([key isEqualToString:@"managementtype"]) {
                    self.managementManagerName=pair[key];
                }
                if ([key isEqualToString:@"management_password"]) {
                    self.managementManagerPassword=pair[key];
                }
                if ([key isEqualToString:@"management_since"]) {
                    self.managementManagerSince=pair[key];
                }
                
            }
        }
        self.message = @"Management Data retreived";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}


-(void)collectUserAccountInfoForUser: (NSString *)email
{
    NSString *string = [NSString stringWithFormat:@"%@get_allusersemail?Email=%@", BaseURLString,email];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"User info collected";
        NSLog(@"%@",self.message);
        NSDictionary *userDict = [self.dataDict objectForKey:@"msg"];
        for (id pair in userDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"goal_steps"]) {
                    self.stepsGoal = pair[key];
                }
                if ([key isEqualToString:@"goal_caloriestoburn"]) {
                    self.calBurnGoal = pair[key];
                }
                if ([key isEqualToString:@"goal_floors"]) {
                    self.floorsGoal = pair[key];
                }
                if ([key isEqualToString:@"goal_activeminutes"]) {
                    self.activeMinutesGoal = pair[key];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}


-(NSString *)getStepsGoal
{
    return self.stepsGoal;
}

-(NSString *)getCalBurnedGoal
{
    return self.calBurnGoal;
}

-(NSString *)getFloorsGoal
{
    return self.floorsGoal;
}

-(NSString *)getActiveMinutesGoal
{
    return self.activeMinutesGoal;
}

-(void) updateLastLogin: (NSString *)email
{
    NSString *string = [NSString stringWithFormat:@"%@update_user_lastlogin?Email=%@", BaseURLString,email];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Last Login updated";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}


-(void) collectLastLoggedInUsers
{
    __block int numberOfLastLogins;
    NSString *string = [NSString stringWithFormat:@"%@get_mailIds", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *loginDict = [self.dataDict objectForKey:@"msg"];
        numberOfLastLogins = [loginDict count];
        self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect users logged in yesterday or today";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(int) getLastLoggedInCount
{
    return self.lastLoginCount;
}


-(void)collectAllDashboardEntriesForUser: (NSString *)email
{
    //__block int numberOfLastLogins;
    NSString *string = [NSString stringWithFormat:@"%@get_alldashboardemail?Email=%@", BaseURLString,email];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *userDashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user";
        NSLog(@"%@",self.message);


        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)collectAllSocialBasedOnEmail: (NSString *)email
{
    __block int numberOfPostsByUser;
    NSString *string = [NSString stringWithFormat:@"%@get_allsocialemail?Email=%@", BaseURLString,email];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *socialDict = [self.dataDict objectForKey:@"msg"];
        numberOfPostsByUser = [socialDict count];
        self.userPostCount = numberOfPostsByUser;
        self.message = @"Collect all social rows for user";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(int) getUserPostCount
{
    return self.userPostCount;
}

-(void)collectAllDashboardEntriesForChallengePartipant2AndDate: (NSString *)email secondParam: (NSString *)date
{
    //__block int numberOfLastLogins;
    //http://sidsachdev.com/webservices/get_dashboard_row?Email=test@email.com&Entry_TimeStamp=2015-12-06
    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,date];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for today";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    self.partipant2steps = pair[key];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
    
}

-(void)collectAllDashboardEntriesForChallengePartipant3AndDate: (NSString *)email secondParam: (NSString *)date
{
    //__block int numberOfLastLogins;
    //http://sidsachdev.com/webservices/get_dashboard_row?Email=test@email.com&Entry_TimeStamp=2015-12-06
    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,date];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for today";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    self.partipant3steps = pair[key];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
    
}

-(void)collectAllDashboardEntriesForChallengePartipant4AndDate: (NSString *)email secondParam: (NSString *)date
{
    //__block int numberOfLastLogins;
    //http://sidsachdev.com/webservices/get_dashboard_row?Email=test@email.com&Entry_TimeStamp=2015-12-06
    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,date];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for today";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    self.partipant4steps = pair[key];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
    
}

-(void)collectAllDashboardEntriesForChallengePartipant5AndDate: (NSString *)email secondParam: (NSString *)date
{
    //__block int numberOfLastLogins;
    //http://sidsachdev.com/webservices/get_dashboard_row?Email=test@email.com&Entry_TimeStamp=2015-12-06
    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,date];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for today";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    self.partipant5steps = pair[key];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
    
}


-(void)collectAllDashboardEntriesForUserAndDate: (NSString *)email secondParam: (NSString *)date
{
    //__block int numberOfLastLogins;
    //http://sidsachdev.com/webservices/get_dashboard_row?Email=test@email.com&Entry_TimeStamp=2015-12-06
    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,date];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for today";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    self.steps = pair[key];
                }
                if ([key isEqualToString:@"Miles"]) {
                    self.miles = pair[key];
                }
                if ([key isEqualToString:@"CaloriesBurned"]) {
                    self.calBurn = pair[key];
                }
                if ([key isEqualToString:@"FloorsClimbed"]) {
                    self.floors = pair[key];
                }
                if ([key isEqualToString:@"BMP_Resting"]) {
                    self.heart = pair[key];
                }
                if ([key isEqualToString:@"ActiveMinutes"]) {
                    self.active = pair[key];
                }
                if ([key isEqualToString:@"CalorieIntake"]) {
                    self.calIntake = pair[key];
                }

            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
    
}

-(void)collectAllDashboardEntriesForUserAndYesterdayDate: (NSString *)email
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //getting yesterday's date
    NSDate* date = [NSDate date];
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    comps.day = -1;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* yesterday = [calendar dateByAddingComponents:comps toDate:date options:nil];
    
    NSString *yesterdayDate = [DateFormatter stringFromDate:yesterday];

    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,yesterdayDate];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for yesterday";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    int value = [pair[key] intValue];
                    if (value > self.stepsYesterday) {
                        self.stepsYesterday = value;
                    }
                }
                if ([key isEqualToString:@"CaloriesBurned"]) {
                    int value = [pair[key] intValue];
                    if (value > self.calBurnYesterday) {
                        self.calBurnYesterday = value;
                    }
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
    
}

-(void)collectAllDashboardEntriesForUserAnd2DaysPastDate: (NSString *)email
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //getting yesterday's date
    NSDate* date = [NSDate date];
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    comps.day = -2;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* yesterday = [calendar dateByAddingComponents:comps toDate:date options:nil];
    
    NSString *yesterdayDate = [DateFormatter stringFromDate:yesterday];
    
    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,yesterdayDate];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for 2 days ago";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    int value = [pair[key] intValue];
                    if (value > self.steps2DaysAgo) {
                        self.steps2DaysAgo = value;
                    }
                }
                if ([key isEqualToString:@"CaloriesBurned"]) {
                    int value = [pair[key] intValue];
                    if (value > self.calBurn2DaysAgo) {
                        self.calBurn2DaysAgo = value;
                    }
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)collectAllDashboardEntriesForUserAnd3DaysPastDate: (NSString *)email
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //getting yesterday's date
    NSDate* date = [NSDate date];
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    comps.day = -3;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* yesterday = [calendar dateByAddingComponents:comps toDate:date options:nil];
    
    NSString *yesterdayDate = [DateFormatter stringFromDate:yesterday];
    
    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,yesterdayDate];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for 3 days ago";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    int value = [pair[key] intValue];
                    if (value > self.steps3DaysAgo) {
                        self.steps3DaysAgo = value;
                    }
                }
                if ([key isEqualToString:@"CaloriesBurned"]) {
                    int value = [pair[key] intValue];
                    if (value > self.calBurn3DaysAgo) {
                        self.calBurn3DaysAgo = value;
                    }
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)collectAllDashboardEntriesForUserAnd4DaysPastDate: (NSString *)email
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //getting yesterday's date
    NSDate* date = [NSDate date];
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    comps.day = -4;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* yesterday = [calendar dateByAddingComponents:comps toDate:date options:nil];
    
    NSString *yesterdayDate = [DateFormatter stringFromDate:yesterday];
    
    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,yesterdayDate];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for 4 days ago";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    int value = [pair[key] intValue];
                    if (value > self.steps4DaysAgo) {
                        self.steps4DaysAgo = value;
                    }
                }
                if ([key isEqualToString:@"CaloriesBurned"]) {
                    int value = [pair[key] intValue];
                    if (value > self.calBurn4DaysAgo) {
                        self.calBurn4DaysAgo = value;
                    }
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)collectAllDashboardEntriesForUserAnd5DaysPastDate: (NSString *)email
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //getting yesterday's date
    NSDate* date = [NSDate date];
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    comps.day = -5;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* yesterday = [calendar dateByAddingComponents:comps toDate:date options:nil];
    
    NSString *yesterdayDate = [DateFormatter stringFromDate:yesterday];
    
    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,yesterdayDate];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for 5 days ago";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    int value = [pair[key] intValue];
                    if (value > self.steps5DaysAgo) {
                        self.steps5DaysAgo = value;
                    }
                }
                if ([key isEqualToString:@"CaloriesBurned"]) {
                    int value = [pair[key] intValue];
                    if (value > self.calBurn5DaysAgo) {
                        self.calBurn5DaysAgo = value;
                    }
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)collectAllDashboardEntriesForUserAnd6DaysPastDate: (NSString *)email
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //getting yesterday's date
    NSDate* date = [NSDate date];
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    comps.day = -6;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* yesterday = [calendar dateByAddingComponents:comps toDate:date options:nil];
    
    NSString *yesterdayDate = [DateFormatter stringFromDate:yesterday];
    
    NSString *string = [NSString stringWithFormat:@"%@get_dashboard_row?Email=%@&Entry_TimeStamp=%@", BaseURLString,email,yesterdayDate];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        NSDictionary *dashboardDict = [self.dataDict objectForKey:@"msg"];
        //numberOfLastLogins = [loginDict count];
        //self.lastLoginCount = numberOfLastLogins;
        self.message = @"Collect all dashboard rows for user for 6 days ago";
        NSLog(@"%@",self.message);
        for (id pair in dashboardDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Steps"]) {
                    int value = [pair[key] intValue];
                    if (value > self.steps6DaysAgo) {
                        self.steps6DaysAgo = value;
                    }
                }
                if ([key isEqualToString:@"CaloriesBurned"]) {
                    int value = [pair[key] intValue];
                    if (value > self.calBurn6DaysAgo) {
                        self.calBurn6DaysAgo = value;
                    }
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}


-(void)returnUsersFriends: (NSString *)email
{
    NSString *string = [NSString stringWithFormat:@"%@get_friends_email?userEmail=%@", BaseURLString,email];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Users friends returned";
        NSLog(@"%@",self.message);
        NSDictionary *friendsDict = [self.dataDict objectForKey:@"msg"];
        self.friends = [NSMutableArray array];
        for (id pair in friendsDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"friendEmail"]) {
                    [self.friends addObject:pair[key]];

                }
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)addFriend: (NSString *)userEmail secondParam: (NSString *)friendEmail
{
    NSString *string = [NSString stringWithFormat:@"%@add_friends_email?friendEmail=%@&userEmail=%@", BaseURLString,friendEmail,userEmail];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Friend added";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}
-(void)collectChallengeInfoBasedOnParticipant:(NSString *)email
{
    NSString *string = [NSString stringWithFormat:@"%@get_challege_byparti?partiEmail=%@", BaseURLString,email];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Challenges info that user participated in collected";
        //NSLog(@"%@",self.message);
        self.userChallengesDict = [self.dataDict objectForKey:@"msg"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

//delete a row in Community Challenge table based on name field
-(void)deleteCommunityChallegefromCommunityChallengeTable: (NSString *)challengeName
{
    NSString *string = [NSString stringWithFormat:@"%@delete_challenges_byname?Challenge_Name=%@", BaseURLString,challengeName];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Challenge deleted in Community Challenge table";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}


//update a row in Community Challenge table based on name field
-(void)updateCommunityChallegefromCommunityChallengeTable: (NSString *)challengeName secondParam: (NSString *)challengeDescription
{
    NSString *string = [NSString stringWithFormat:@"%@update_challange_onname?CommChallengeName=%@&CommChallengeDescription=%@", BaseURLString,challengeName,challengeDescription];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Challenge updated in Community Challenge Table";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}


//add a row in Community Challenge table
-(void)addCommunityChallegefromCommunityChallengeTable: (NSString *)challengeName secondParam: (NSString *)challengeDescription
{
    NSString *string = [NSString stringWithFormat:@"%@add_challenge_row?CommChallengeName=%@&CommChallengeDescription=%@", BaseURLString,challengeName,challengeDescription];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Challenge added to Community Challenge table";
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}


//return row in Community Challenge table based on name field
-(void)collectCommunityChallegefromCommunityChallengeTable:(NSString *)challengeName
{
    NSString *string = [NSString stringWithFormat:@"%@get_allchallegename?CommChallengeName=%@", BaseURLString,challengeName];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Challenges info based on name collected from community challenge table";
        NSDictionary *communityChallengeDict = [self.dataDict objectForKey:@"msg"];
        NSLog(@"%@",self.message);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}

-(void)getCurrentCommunityChallenges
{
    NSString *string = [NSString stringWithFormat:@"%@get_challenge_name?Challenge_NAME=community", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = (NSDictionary *)responseObject;
        self.message = @"Challenges info based on name collected from community challenge table";
        NSDictionary *currentCommunityChallengeDict = [self.dataDict objectForKey:@"msg"];
        NSLog(@"%@",self.message);
        self.currentCommunityChallenges = [NSMutableArray array];
        for (id pair in currentCommunityChallengeDict) {
            NSLog(@"%@", pair);
            for (id key in pair){
                NSLog(@"%@", key);//field
                NSLog(@"%@", pair[key]);
                if ([key isEqualToString:@"Challenge_Activity_Type"]) {
                    [self.currentCommunityChallenges addObject:pair[key]];
                    
                }
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Retreiving Data: %@",error);
    }];
    
    [operation start];
}





@end
