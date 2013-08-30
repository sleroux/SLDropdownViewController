//
//  SLDropdownViewController.h
//  SLDropdownViewController
//
//  Created by Stephan Leroux on 2013-08-30.
//  Copyright (c) 2013 Stephan Leroux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLDropdownProtocols.h"

@interface SLDropdownViewController : UIViewController <SLDropdownOptionDelegate>

@property (weak, nonatomic) id<SLDropdownViewControllerDataSource> dataSource;

- (id)init;

@end
