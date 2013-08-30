//
//  SLDropdownOptionViewController.m
//  SLDropdownViewController
//
//  Created by Stephan Leroux on 2013-08-30.
//  Copyright (c) 2013 Stephan Leroux. All rights reserved.
//

#import "SLDropdownOptionViewController.h"
#import "SLSimpleDropdownOptionCell.h"

@interface SLDropdownOptionViewController ()

@end

@implementation SLDropdownOptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SLSimpleDropdownOptionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SimpleDropdownOptionCellIdentifier];

    NSInteger numOfRows = [self tableView:self.tableView numberOfRowsInSection:0];
    
    for (int rowIndex = 0; rowIndex < numOfRows; rowIndex++) {
        _dropdownHeight += [self tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:0]];
    }
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
    if (self.dropdownDataSource) {
        return [self.dropdownDataSource numberOfDropdownOptions];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLSimpleDropdownOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleDropdownOptionCellIdentifier forIndexPath:indexPath];
    
    if (self.dropdownDataSource) {
        cell.optionLabel.text = [self.dropdownDataSource optionNameAtIndexPath:indexPath];
    } else {
        cell.optionLabel.text = nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.optionDelegate && [self.optionDelegate respondsToSelector:@selector(didSelectOptionAtIndexPath:)]) {
        [self.optionDelegate didSelectOptionAtIndexPath:indexPath];
    }
}

@end
