//
//  TaskCell.h
//  InDueTime
//
//  Created by Ross Gottschalk on 8/2/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UISwitch *taskSwitch;

@end
