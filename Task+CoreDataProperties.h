//
//  Task+CoreDataProperties.h
//  InDueTime
//
//  Created by Ross Gottschalk on 8/2/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *switcher;
@property (nullable, nonatomic, retain) NSString *taskName;

@end

NS_ASSUME_NONNULL_END
