//
//  ToDoTableViewController.m
//  InDueTime
//
//  Created by Ross Gottschalk on 8/2/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "TaskCell.h"
#import "AppDelegate.h"
#import "Task.h"
#import <CoreData/CoreData.h>


@interface ToDoTableViewController () <UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *tasks;
@property (strong, nonatomic) NSManagedObjectContext *moc;


@end

@implementation ToDoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"To-Do List";
    self.tasks = [[NSMutableArray alloc] init];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Task class])];
    NSError *error = nil;
    NSArray *tasksFromCoreData = [self.moc executeFetchRequest:fetchRequest error:&error];
    if (error)
    {
        NSLog(@"Could not fetch from moc: %@", [error localizedDescription]);
    }
    else
    {
        [self.tasks addObjectsFromArray:tasksFromCoreData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    
    
    // Configure the cell...
    Task *aNewTask = self.tasks [indexPath.row];
    if(aNewTask.taskName && ![aNewTask.taskName isEqualToString:@""])
    {

        [cell.taskNameTextField setText:aNewTask.taskName];
        
    }
    else
    {
        [cell.taskNameTextField becomeFirstResponder];
    }
    
    
    return cell;
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
#pragma - UITextField delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    if (![textField.text isEqualToString:@""])
    {
        UIView *contentView = [textField superview];
        TaskCell *cell = (TaskCell *) [contentView superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Task *aNewTask = self.tasks [indexPath.row];
        aNewTask.taskName = textField.text;
        [textField resignFirstResponder];
        [self saveContext];
    }
    return rc;
}

#pragma - Action Handlers
-(IBAction)addTask:(id)sender
{
    Task *aNewTask = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Task class]) inManagedObjectContext:self.moc];
    [self.tasks addObject:aNewTask];
    [self.tableView reloadData];
}

-(IBAction)taskSwitch:(UISwitch *)sender
{
    UIView *contentView = [sender superview];
    TaskCell *cell = (TaskCell *) [contentView superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Task *aNewTask = self.tasks [indexPath.row];
    
}

#pragma - Misc.
-(void)saveContext
{
    NSError *error = nil;
    [self.moc save:&error];
    if (error)
    {
        NSLog(@"Error for saving moc: %@", [error localizedDescription]);
    }

}

@end
