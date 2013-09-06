//
//  SLSimpleDropdownViewController.m
//  SLDropdownViewController
//
//  Created by Stephan Leroux on 2013-08-30.
//  Copyright (c) 2013 Stephan Leroux. All rights reserved.
//

#import "SLSimpleDropdownViewController.h"
#import "SLSimpleDropdownOptionCell.h"

@interface SLSimpleDropdownViewController ()

@end

@implementation SLSimpleDropdownViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = self;
    self.optionTableView.dataSource = self;
    self.optionTableView.delegate = self;
    self.optionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.optionTableView registerNib:[UINib nibWithNibName:@"SLSimpleDropdownOptionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SimpleDropdownOptionCellIdentifier];
    
    self.optionTableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
}

# pragma mark - Dropdown Datasource

- (UIViewController *)viewControllerForOptionAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = [[UIViewController alloc] init];
    
    switch (indexPath.row) {
        case 0: {
            viewController.view.backgroundColor = [UIColor greenColor];
            break;
        }
            
        case 1: {
            viewController.view.backgroundColor = [UIColor redColor];
            break;
        }
            
        case 2: {
            viewController.view.backgroundColor = [UIColor yellowColor];
            break;
        }
        default:
            return nil;
    }
    
    viewController.title = [NSString stringWithFormat:@"Option %d", indexPath.row];
    return viewController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLSimpleDropdownOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleDropdownOptionCellIdentifier forIndexPath:indexPath];
    cell.optionLabel.text = [NSString stringWithFormat:@"Option %d", indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

# pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self didSelectOptionAtIndexPath:indexPath];
}

@end
