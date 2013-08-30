//
//  SLDropdownOptionViewController.h
//  SLDropdownViewController
//
//  Created by Stephan Leroux on 2013-08-30.
//  Copyright (c) 2013 Stephan Leroux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLDropdownProtocols.h"

@interface SLDropdownOptionViewController : UITableViewController

@property (assign, nonatomic, readonly) NSInteger dropdownHeight;
@property (weak, nonatomic) id<SLDropdownViewControllerDataSource> dropdownDataSource;
@property (weak, nonatomic) id<SLDropdownOptionDelegate> optionDelegate;

@end
