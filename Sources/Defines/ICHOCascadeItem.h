//
//  ICHOCascadeItem.h
//  CHOCascadeViewController
//
//  Created by chojd on 11/10/2016.
//  Copyright © 2016 chojd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ICHOCascadeItem <NSObject>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign, getter=isOpened) BOOL opened;
@property (nullable, nonatomic, strong) NSArray <ICHOCascadeItem>*subItems;

@end
NS_ASSUME_NONNULL_END
