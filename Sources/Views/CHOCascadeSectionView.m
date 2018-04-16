//
//  CHOCascadeSectionView.m
//  CHOCascadeViewController
//
//  Created by chojd on 11/10/2016.
//  Copyright © 2016 chojd. All rights reserved.
//

#import "CHOCascadeSectionView.h"

@interface CHOCascadeSectionView ()

@property (nonatomic, weak, readwrite) id<ICHOCascadeItem>cascadeItem;
@property (nonatomic, strong) UIView *indicatorLine;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation CHOCascadeSectionView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:244.f/255.f green:244.f/255.f blue:244.f/255.f alpha:1.f];
        [self buildTapGestureRecognizer];
        [self buildIndicatorLine];
        [self buildTitleLabel];
        [self buildArrowImageView];
        [self buildBottomLine];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [super updateConstraints];

    //  indicator line
    [self.indicatorLine addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:3]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.f constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorLine attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0]];
    
    
    //  title label
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.f constant:20]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeRight multiplier:1.f constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0]];
    
    //  bottom line
    [self.bottomLine addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:0.5]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.f constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0]];
}

#pragma mark - Public
- (void)reloadWithCascadeItem:(id<ICHOCascadeItem>)cascadeItem {
    self.cascadeItem = cascadeItem;
    self.titleLabel.text = [cascadeItem title];
    
    [self showIndicator:[cascadeItem isOpened] animated:YES];
    [self arrowDown:[cascadeItem isOpened] animated:YES];
    
    [self setNeedsUpdateConstraints];
}

#pragma mark - Action
- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGesRec {
    if (![self.delegate respondsToSelector:@selector(sectionHeaderView:didSelectedCascadeItem:)]) {
        return;
    }
    [self.delegate sectionHeaderView:self didSelectedCascadeItem:self.cascadeItem];
}

#pragma mark - Private
- (void)showIndicator:(BOOL)show animated:(BOOL)animated {
    if (show) { self.indicatorLine.hidden = NO; }
    
    [UIView animateWithDuration:animated ? 0.25f : 0.f
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^
     {
         self.indicatorLine.transform = CGAffineTransformMakeScale(1.f, show ? 1.f : 0);
     }
                     completion:^(BOOL finished)
     {
         if (!show) { self.indicatorLine.hidden = YES; }
     }];
}

- (void)arrowDown:(BOOL)down animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.25f : 0.f animations:^{
        self.arrowImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, down ? M_PI_2 : 0.f);
    }];
}

#pragma mark - Override Touchs
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [UIView animateWithDuration:0.15f animations:^{
        self.contentView.backgroundColor = [UIColor colorWithRed:232.f/255.f green:232.f/255.f blue:232.f/255.f alpha:1.f];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [UIView animateWithDuration:0.15f animations:^{
        self.contentView.backgroundColor = [UIColor colorWithRed:244.f/255.f green:244.f/255.f blue:244.f/255.f alpha:1.f];
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [UIView animateWithDuration:0.15f animations:^{
        self.contentView.backgroundColor = [UIColor colorWithRed:244.f/255.f green:244.f/255.f blue:244.f/255.f alpha:1.f];
    }];
}

#pragma mark - Builder
- (void)buildTapGestureRecognizer {
    UITapGestureRecognizer *tapGesRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self.contentView addGestureRecognizer:tapGesRec];
}

- (void)buildIndicatorLine {
    self.indicatorLine = [[UIView alloc] init];
    self.indicatorLine.hidden = YES;
    self.indicatorLine.transform = CGAffineTransformMakeScale(1.f, 0);
    self.indicatorLine.translatesAutoresizingMaskIntoConstraints = NO;
    self.indicatorLine.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.indicatorLine];
}

- (void)buildTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
}

- (void)buildArrowImageView {
    self.arrowImageView = [[UIImageView alloc] init];
    self.arrowImageView.translatesAutoresizingMaskIntoConstraints = NO; 
//    self.arrowImageView.image = [UIImage imageNamed:@"home_right_icon"];
    [self.contentView addSubview:self.arrowImageView];
}

- (void)buildBottomLine {
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomLine.backgroundColor = [UIColor colorWithRed:221.f/255.f green:221.f/255.f blue:221.f/255.f alpha:1.f];
    [self.contentView addSubview:self.bottomLine];
}

@end
