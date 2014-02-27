//
//  TableViewController.h
//  FileBrowser
//
//  Created by Ryan Heitner on 01/01/2014.
//  Copyright (c) 2014 Ryan Heitner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSArray *filesArray;


- (IBAction)addFile:(id)sender;
- (IBAction)addDirectory:(id)sender;



@end
