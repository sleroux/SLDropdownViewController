//
//  SLDropdownViewController.m
//  SLDropdownViewController
//
//  Created by Stephan Leroux on 2013-08-30.
//  Copyright (c) 2013 Stephan Leroux. All rights reserved.
//

#import "SLDropdownViewController.h"

typedef NS_ENUM(NSInteger, SLDropdownOptionState) {
    DropdownOpen,
    DropdownClosed,
    DropdownAnimating
};

@interface SLDropdownViewController ()

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIViewController *rootViewController;
@property (assign, nonatomic) SLDropdownOptionState dropdownState;

@end

@implementation SLDropdownViewController

- (id)init
{
    self = [super init];

    if (self) {
        self.optionTableView = [[UITableView alloc] init];
        self.dropdownState = DropdownClosed;
    }
    
    return self;
}

- (void)setDataSource:(id<SLDropdownViewControllerDataSource>)dataSource
{
    _dataSource = dataSource;
    
    if (self.navigationController) {
        [self.navigationController willMoveToParentViewController:self];
        [self.navigationController removeFromParentViewController];
        [self.navigationController.view removeFromSuperview];
    }
    
    self.rootViewController = [self.dataSource viewControllerForOptionAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
    [self.navigationController.navigationBar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleDropdown)]];
    [self.navigationController willMoveToParentViewController:self];
    [self addChildViewController:self.navigationController];
    self.navigationController.view.frame = self.view.bounds;
    [self.view addSubview:self.navigationController.view];
}

- (void)didSelectOptionAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource) {
        UIViewController *viewController = [self.dataSource viewControllerForOptionAtIndexPath:indexPath];
        self.navigationController.viewControllers = @[viewController];
        [self toggleDropdown];
    }
}

- (void)toggleDropdown
{
    // Calculate dropdown height for animation from dropdown table view controller
    NSInteger numOfRows = [self.optionTableView.dataSource tableView:self.optionTableView numberOfRowsInSection:0];
    
    CGFloat dropdownHeight = 0;
    for (int rowIndex = 0; rowIndex < numOfRows; rowIndex++) {
        dropdownHeight += [self.optionTableView.delegate tableView:self.optionTableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:0]];
    }
    
    self.optionTableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), dropdownHeight);
 
    if (self.dropdownState == DropdownClosed) {
        self.optionTableView.frame = CGRectMake(0, 44 - dropdownHeight, CGRectGetWidth(self.view.frame), dropdownHeight);
        [self.navigationController.view insertSubview:self.optionTableView belowSubview:self.navigationController.navigationBar];
        
        self.dropdownState = DropdownAnimating;
        
        [UIView animateWithDuration:0.1 animations:^{
            self.optionTableView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.frame), dropdownHeight);
        } completion:^(BOOL finished) {
            self.dropdownState = DropdownOpen;
        }];
        
        self.dropdownState = DropdownOpen;
    } else if(self.dropdownState == DropdownOpen) {
        [UIView animateWithDuration:0.1 animations:^{
            self.optionTableView.frame = CGRectMake(0, 44 - dropdownHeight, CGRectGetWidth(self.view.frame), dropdownHeight);
        } completion:^(BOOL finished) {
            [self.optionTableView removeFromSuperview];
            self.dropdownState = DropdownClosed;
        }];
    }
}

@end
