//
//  CHOCascadeItem.h
//  CHOCascadeViewController
//
//  Created by chojd on 16/10/11.
//  Copyright © 2016年 chojd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICHOCascadeItem.h"

@interface CHOCascadeItem : NSObject <ICHOCascadeItem>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign, getter=isOpened) BOOL opened;
@property (nullable, nonatomic, strong) NSArray <ICHOCascadeItem>*subItems;

@end
