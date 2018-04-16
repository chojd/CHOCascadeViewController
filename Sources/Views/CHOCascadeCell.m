//
//  CHOCascadeCell.m
//  CHOCascadeViewController
//
//  Created by chojd on 11/10/2016.
//  Copyright © 2016 chojd. All rights reserved.
//

#import "CHOCascadeCell.h"

@interface CHOCascadeCell ()

@property (nonatomic, weak, readwrite) id<ICHOCascadeItem>item;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CHOCascadeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.separatorInset = UIEdgeInsetsMake(FLT_MAX, 0.f, 0.f, 0.f);
        [self buildTapGestureRecognizer];
        [self buildTitleLabel];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [super updateConstraints];

    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.f constant:40.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0]];
}

#pragma mark - Action
- (void)handlTapGesRec:(UITapGestureRecognizer *)tapGesRec {
    if (![self.delegate respondsToSelector:@selector(cascadeCell:didSelctedCascadeItem:)]) {
        return;
    }
    [self.delegate cascadeCell:self didSelctedCascadeItem:self.item];
}

#pragma mark - Public
- (void)reloadWithItem:(id<ICHOCascadeItem>)item {
    self.item = item;
    self.titleLabel.text = [item title];
    
    [self setNeedsUpdateConstraints];
}

#pragma mark - Builder
- (void)buildTapGestureRecognizer {
    UITapGestureRecognizer *tapGesRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlTapGesRec:)];
    [self.contentView addGestureRecognizer:tapGesRec];
}
- (void)buildTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorWithRed:68.f/255.f green:68.f/255.f blue:68.f/255.f alpha:1.f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [self.contentView addSubview:self.titleLabel];
}

@end
