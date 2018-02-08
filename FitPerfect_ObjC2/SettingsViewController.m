//
//  SettingsViewController.m
//  FitPerfect_ObjC2
//
//  Created by Janina Grayson on 10/26/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "SettingsViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SettingsDetailViewController.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController{
   NSArray *settings; //creating a static array where size is fixed
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //instantiate settings NSArray object and preloaded with settings fields
    settings = [NSArray arrayWithObjects:@"Connect a device", @"Edit user profile", @"Change Password", @"Share location", @"About application", @"FAQ", @"LogOut", nil];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"FitPerfect_header.jpg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// inform the table view how many rows are in the section. So let’s add the below code. The count: method simply returns the number of items in the “tableData” array
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [settings count];
}

//called every time when a table row is displayed.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SettingsTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [settings objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SettingsDetail"]) {
        //row clicked on
        NSIndexPath *indexPath =[self.tableview indexPathForSelectedRow];
        SettingsDetailViewController *destViewController = segue.destinationViewController;
        //name will be settings name picked
        destViewController.settingDetail = [settings objectAtIndex:indexPath.row];
        //destViewController.title = destViewController.settingDetail;
        destViewController.title = @"";
        
    }
}

/*
- (IBAction)facebookLogout:(UIButton *)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc]init];
    if ([FBSDKAccessToken currentAccessToken]) {
        [login logOut];
    }
}
 */
@end
