//
//  CHOCascadeViewControllerDelegate.h
//  CHOCascadeViewController
//
//  Created by JingdaCao on 2018/4/16.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@protocol ICHOCascadeItem;
@protocol CHOCascadeViewControllerDelegate <NSObject>

- (void)cascadeController:(UIViewController *)viewController didSelectedItem:(id<ICHOCascadeItem>)item;
- (void)cancelSelectedInCascadeController:(UIViewController *)viewController;

@end
