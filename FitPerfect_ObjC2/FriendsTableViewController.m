//
//  FriendsTableViewController.m
//  FitPerfect
//
//  Created by Janina Grayson on 12/11/15.
//  Copyright © 2015 Janina Grayson. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "PotentialFriendsTableViewCell.h"
#import "DataModel.h"

@interface FriendsTableViewController ()

@end

@implementation FriendsTableViewController{
    DataModel *data;
    NSMutableArray *firstName;
    NSMutableArray *lastName;
    NSMutableArray *email;
    NSString *friendEmail;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"FitPerfect_header.jpg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    data =[[DataModel alloc]init];
    [data calculateNumberOfUsers];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [firstName count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *simpleTableIdentifier = @"PotentialFriendsCell";
 
        PotentialFriendsTableViewCell *cell = (PotentialFriendsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PotentialFriendsCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
 ;
    cell.name.text = [NSString stringWithFormat:@"%@ %@", [firstName objectAtIndex:indexPath.row], [lastName objectAtIndex:indexPath.row]];
    cell.email.text = [email objectAtIndex:indexPath.row];
 
    return cell;

}

//when a row is selected:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //displaying a check mark when a row is selected
    //The first line retrieves the selected table cell by using the indexPath. The second link updates the accessory view of the cell with a check mark
    PotentialFriendsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    
    friendEmail = cell.email.text;

    
}


- (IBAction)seePotentialFriends:(UIBarButtonItem *)sender {
    firstName = data.firstName;
    lastName = data.lastName;
    email = data.userEmail;
    [self.tableView reloadData];
}

- (IBAction)addAFriend:(UIButton *)sender {
    [data addFriend:[[NSUserDefaults standardUserDefaults]valueForKey:@"email"] secondParam:friendEmail];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
