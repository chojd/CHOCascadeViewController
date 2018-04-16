//
//  CHOCascadeSectionView.h
//  CHOCascadeViewController
//
//  Created by chojd on 11/10/2016.
//  Copyright © 2016 chojd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICHOCascadeItem.h"

@protocol CHOCascadeSectionViewDelegate;
@interface CHOCascadeSectionView : UITableViewHeaderFooterView

@property (nonatomic, weak, readonly) id<ICHOCascadeItem>cascadeItem;
@property (nonatomic, weak) id<CHOCascadeSectionViewDelegate>delegate;

- (void)reloadWithCascadeItem:(id<ICHOCascadeItem>)cascadeItem;

@end

@protocol CHOCascadeSectionViewDelegate <NSObject>

- (void)sectionHeaderView:(CHOCascadeSectionView *)sectionView didSelectedCascadeItem:(id<ICHOCascadeItem>)cascadeItem;

@end
