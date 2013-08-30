//
//  SLSimpleDropdownOptionCell.h
//  SLDropdownViewController
//
//  Created by Stephan Leroux on 2013-08-30.
//  Copyright (c) 2013 Stephan Leroux. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const SimpleDropdownOptionCellIdentifier = @"SimpleDropdownOptionCellIdentifier";

@interface SLSimpleDropdownOptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *optionLabel;

@end
