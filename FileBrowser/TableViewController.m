//
//  TableViewController.m
//  FileBrowser
//
//  Created by Ryan Heitner on 01/01/2014.
//  Copyright (c) 2014 Ryan Heitner. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"
#define kAddFileTitle @"Add File"
#define kAddDirectoryTitle @"Add Directory"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *files = [fm contentsOfDirectoryAtPath:[TableViewController getDocsPath] error:nil];
    self.filesArray = files;

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.filesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.filesArray objectAtIndex:indexPath.row];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */




- (IBAction)addFile:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:kAddFileTitle
                                                     message:@"INPUT BELOW"
                                                    delegate:self
                                           cancelButtonTitle:@"Enter"
                                           otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)addDirectory:(id)sender{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:kAddDirectoryTitle
                                                     message:@"INPUT BELOW"
                                                    delegate:self
                                           cancelButtonTitle:@"Enter"
                                           otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *response = [[alertView textFieldAtIndex:0] text];
    if ([[alertView title] isEqualToString:kAddFileTitle]) {
        NSString *filePath = [[TableViewController getDocsPath] stringByAppendingPathComponent:response];
        NSString *str = @"hello world";
        [str writeToFile:filePath  atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
    } else {
        NSString *dataPath = [[TableViewController getDocsPath] stringByAppendingPathComponent:response];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
    }
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *files = [fm contentsOfDirectoryAtPath:[TableViewController getDocsPath] error:nil];
    self.filesArray = files;

    [self.tableView reloadData];
    
    
}


+ (NSString *) getDocsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0]; //Get the docs directory
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    DetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    dvc.file = [self.filesArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}


@end
