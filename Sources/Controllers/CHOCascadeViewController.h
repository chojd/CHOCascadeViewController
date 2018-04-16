//
//  CHOCascadeViewController.h
//  CHOCascadeViewController
//
//  Created by chojd on 10/10/2016.
//  Copyright © 2016 chojd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ICHOCascadeItem.h"
#import "CHOCascadeViewControllerDelegate.h"

@protocol CHOCascadeViewControllerDelegate;
@interface CHOCascadeViewController : UIViewController

@property (nonatomic, strong, readonly) NSArray <ICHOCascadeItem>*items;
@property (nonatomic, weak, readonly) id<CHOCascadeViewControllerDelegate>delegate;

- (instancetype)initWithItems:(NSArray <ICHOCascadeItem>*)items delegate:(id<CHOCascadeViewControllerDelegate>)delegate;

- (void)showInViewController:(UIViewController *)viewController;
- (void)removeFromViewController:(UIViewController *)viewController;

@end
