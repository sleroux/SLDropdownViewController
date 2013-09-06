//
//  SLDropdownViewController.h
//  SLDropdownViewController
//
//  Created by Stephan Leroux on 2013-08-30.
//  Copyright (c) 2013 Stephan Leroux. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLDropdownViewControllerDataSource <NSObject>

@required
- (UIViewController *)viewControllerForOptionAtIndexPath:(NSIndexPath *)indexPath;
@end

@class SLDropdownOptionViewController;

@interface SLDropdownViewController : UIViewController

@property (weak, nonatomic) id<SLDropdownViewControllerDataSource> dataSource;
@property (strong, nonatomic) UITableView *optionTableView;

- (id)init;
- (void)didSelectOptionAtIndexPath:(NSIndexPath *)indexPath;

@end
