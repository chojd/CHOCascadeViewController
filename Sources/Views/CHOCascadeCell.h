//
//  CHOCascadeCell.h
//  CHOCascadeViewController
//
//  Created by chojd on 11/10/2016.
//  Copyright © 2016 chojd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICHOCascadeItem.h"

@protocol CHOCascadeCellDelegate;
@interface CHOCascadeCell : UITableViewCell

@property (nonatomic, weak, readonly) id<ICHOCascadeItem>item;
@property (nonatomic, weak) id<CHOCascadeCellDelegate>delegate;

- (void)reloadWithItem:(id<ICHOCascadeItem>)item __attribute__((objc_requires_super));

@end

@protocol CHOCascadeCellDelegate <NSObject>

- (void)cascadeCell:(CHOCascadeCell *)cell didSelctedCascadeItem:(id<ICHOCascadeItem>)cascadeItem;

@end
