//
//  SLDropdownViewController.m
//  SLDropdownViewController
//
//  Created by Stephan Leroux on 2013-08-30.
//  Copyright (c) 2013 Stephan Leroux. All rights reserved.
//

#import "SLDropdownViewController.h"
#import "SLDropdownOptionViewController.h"

typedef NS_ENUM(NSInteger, SLDropdownOptionState) {
    DropdownOpen,
    DropdownClosed,
    DropdownAnimating
};

@interface SLDropdownViewController ()

@property (strong, nonatomic) UINavigationBar *navigationBar;
@property (strong, nonatomic) UIViewController *rootViewController;
@property (strong, nonatomic) SLDropdownOptionViewController *optionsTableViewController;
@property (assign, nonatomic) SLDropdownOptionState dropdownState;

@end

@implementation SLDropdownViewController

- (id)init
{
    self = [super init];

    if (self) {
        self.optionsTableViewController = [[SLDropdownOptionViewController alloc] init];
        self.optionsTableViewController.optionDelegate = self;
        self.dropdownState = DropdownClosed;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.dataSource) {
        self.rootViewController = [self.dataSource viewControllerForOptionAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
        [self.view addSubview:self.navigationBar];
        [self.navigationBar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleDropdown)]];
        [self.rootViewController willMoveToParentViewController:self];
        [self addChildViewController:self.rootViewController];
        self.rootViewController.view.frame = CGRectMake(0, CGRectGetHeight(self.navigationBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        [self.view addSubview:self.rootViewController.view];
    }
}

- (void)setDataSource:(id<SLDropdownViewControllerDataSource>)dataSource
{
    // Pass along the data source reference to the option view controller
    _dataSource = dataSource;
    self.optionsTableViewController.dropdownDataSource = dataSource;
}

- (void)toggleDropdown
{
    if (self.dropdownState == DropdownClosed) {
        self.optionsTableViewController.view.frame = CGRectMake(0, 44 - self.optionsTableViewController.dropdownHeight, CGRectGetWidth(self.view.frame), self.optionsTableViewController.dropdownHeight);
        [self.optionsTableViewController willMoveToParentViewController:self];
        [self addChildViewController:self.optionsTableViewController];
        [self.view insertSubview:self.optionsTableViewController.view belowSubview:self.navigationBar];
        
        self.dropdownState = DropdownAnimating;
        
        [UIView animateWithDuration:0.1 animations:^{
            self.optionsTableViewController.view.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.frame), self.optionsTableViewController.dropdownHeight);
        } completion:^(BOOL finished) {
            self.dropdownState = DropdownOpen;
        }];
        
        self.dropdownState = DropdownOpen;
    } else if(self.dropdownState == DropdownOpen) {
        [self.optionsTableViewController willMoveToParentViewController:self];
        [self.optionsTableViewController removeFromParentViewController];
        [self.optionsTableViewController.view removeFromSuperview];
        self.dropdownState = DropdownClosed;
    }
}

- (void)changeFromViewController:(UIViewController *)oldViewController
                toViewController:(UIViewController *)newViewController
{
    self.dropdownState = DropdownAnimating;
    
    [self addChildViewController:newViewController];
    newViewController.view.frame = CGRectMake(0, CGRectGetHeight(self.navigationBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:newViewController.view];
    
    CGRectMake(0, CGRectGetHeight(self.navigationBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));

    [UIView animateWithDuration:0.1 animations:^{
        // Close the dropdown and also cross fade the view controllers
        oldViewController.view.alpha = 0.0f;
        newViewController.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self.rootViewController willMoveToParentViewController:self];
        [self.rootViewController removeFromParentViewController];
        self.rootViewController = newViewController;
        self.dropdownState = DropdownClosed;
    }];
}

# pragma mark - Dropdown Option Delegate

- (void)didSelectOptionAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource) {
        UIViewController *viewController = [self.dataSource viewControllerForOptionAtIndexPath:indexPath];
        viewController.view.alpha = 0.0f;
        [self changeFromViewController:self.rootViewController toViewController:viewController];
    }
}

@end
