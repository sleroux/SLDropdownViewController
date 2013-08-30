//
//  SLDropdownProtocols.h
//  SLDropdownViewController
//
//  Created by Stephan Leroux on 2013-08-30.
//  Copyright (c) 2013 Stephan Leroux. All rights reserved.
//

#ifndef SLDropdownViewController_SLDropdownProtocols_h
#define SLDropdownViewController_SLDropdownProtocols_h

@protocol SLDropdownViewControllerDataSource <NSObject>

@required
- (NSString *)optionNameAtIndexPath:(NSIndexPath *)indexPath;
- (UIViewController *)viewControllerForOptionAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfDropdownOptions;

@end

@protocol SLDropdownOptionDelegate <NSObject>

- (void)didSelectOptionAtIndexPath:(NSIndexPath *)indexPath;

@end

#endif
