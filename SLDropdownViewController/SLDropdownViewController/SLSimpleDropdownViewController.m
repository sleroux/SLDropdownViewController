//
//  SLSimpleDropdownViewController.m
//  SLDropdownViewController
//
//  Created by Stephan Leroux on 2013-08-30.
//  Copyright (c) 2013 Stephan Leroux. All rights reserved.
//

#import "SLSimpleDropdownViewController.h"

@interface SLSimpleDropdownViewController ()

@end

@implementation SLSimpleDropdownViewController

- (id)init
{
    self = [super init];
    
    if (self) {
        self.dataSource = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

# pragma mark - Dropdown Datasource

- (NSString *)optionNameAtIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"Option %d", indexPath.row];
}

- (UIViewController *)viewControllerForOptionAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: {
            UIViewController *viewController = [[UIViewController alloc] init];
            viewController.view.backgroundColor = [UIColor greenColor];
            return viewController;
        }
            
        case 1: {
            UIViewController *viewController = [[UIViewController alloc] init];
            viewController.view.backgroundColor = [UIColor redColor];
            return viewController;
        }
            
        case 2: {
            UIViewController *viewController = [[UIViewController alloc] init];
            viewController.view.backgroundColor = [UIColor yellowColor];
            return viewController;
        }
        default:
            return nil;
    }
}

- (NSInteger)numberOfDropdownOptions
{
    return 3;
}

@end
