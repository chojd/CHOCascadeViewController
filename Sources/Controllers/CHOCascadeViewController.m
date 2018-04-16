//
//  CHOCascadeViewController.m
//  CHOCascadeViewController
//
//  Created by chojd on 10/10/2016.
//  Copyright © 2016 chojd. All rights reserved.
//

#import "CHOCascadeViewController.h"

#import "CHOCascadeCell.h"
#import "CHOCascadeSectionView.h"

@interface CHOCascadeViewController ()
<UITableViewDelegate, UITableViewDataSource,
CHOCascadeSectionViewDelegate, CHOCascadeCellDelegate>

@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong, readwrite) NSArray <ICHOCascadeItem>*items;
@property (nonatomic, weak, readwrite) id<CHOCascadeViewControllerDelegate>delegate;

@end

@implementation CHOCascadeViewController

- (instancetype)initWithItems:(NSArray <ICHOCascadeItem>*)items delegate:(id<CHOCascadeViewControllerDelegate>)delegate {
    if (self = [super init]) {
        self.items = items;
        self.delegate = delegate;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildCancelTapGestureRecognizer];
    [self buildVisualView];
    
    [self buildTableView];
    [UIView animateWithDuration:0.25f animations:^{
        self.tableView.center = CGPointMake(CGRectGetWidth(self.tableView.bounds) / 2.f, self.tableView.center.y);
        self.visualEffectView.alpha = 1.f;
    }];
}

#pragma mark - Action
- (void)handleCancelTapGestureRecognizer:(UIGestureRecognizer *)gesRec {
    if (![self.delegate respondsToSelector:@selector(cancelSelectedInCascadeController:)]) {
        return;
    }
    [self.delegate cancelSelectedInCascadeController:self];
}

#pragma mark - Public
- (void)showInViewController:(UIViewController *)viewController {
    [self willMoveToParentViewController:viewController];
    [viewController addChildViewController:self];
    self.view.frame = viewController.view.bounds;
    [viewController.view addSubview:self.view];
    [self didMoveToParentViewController:viewController];
}

- (void)removeFromViewController:(UIViewController *)viewController {
    if (![viewController.childViewControllers containsObject:self]) { return; }
    
    [UIView animateWithDuration:0.25f animations:^{
        self.tableView.center = CGPointMake(-CGRectGetWidth(self.tableView.bounds)/2, self.tableView.center.y);
        self.visualEffectView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

#pragma mark - Builder
- (void)buildVisualView {
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.visualEffectView.alpha = 0.f;
    self.visualEffectView.frame = self.view.bounds;
    [self.view addSubview:self.visualEffectView];
}
- (void)buildTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(-(self.view.bounds.size.width * 0.6), 0.f, self.view.bounds.size.width * 0.6, self.view.bounds.size.height - 64.f) style:UITableViewStylePlain];
    [self.tableView registerClass:[CHOCascadeCell class] forCellReuseIdentifier:NSStringFromClass([CHOCascadeCell class])];
    [self.tableView registerClass:[CHOCascadeSectionView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([CHOCascadeSectionView class])];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)buildCancelTapGestureRecognizer {
    UITapGestureRecognizer *tapGesRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCancelTapGestureRecognizer:)];
    [self.view addGestureRecognizer:tapGesRec];
    
    UISwipeGestureRecognizer *swipGesRec = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleCancelTapGestureRecognizer:)];
    swipGesRec.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipGesRec];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<ICHOCascadeItem>item = self.items[section];
    return [item isOpened] ? [[item subItems] count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CHOCascadeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CHOCascadeCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    [cell reloadWithItem:[self.items[indexPath.section] subItems][indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CHOCascadeSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([CHOCascadeSectionView class])];
    if (!sectionView) {
        sectionView = [[CHOCascadeSectionView alloc] initWithReuseIdentifier:NSStringFromClass([CHOCascadeSectionView class])];
    }
    sectionView.delegate = self;
    [sectionView reloadWithCascadeItem:self.items[section]];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}

#pragma mark - CHOCascadeCellDelegate
- (void)cascadeCell:(CHOCascadeCell *)cell didSelctedCascadeItem:(id<ICHOCascadeItem>)cascadeItem {
    if (![self.delegate respondsToSelector:@selector(cascadeController:didSelectedItem:)]) { return; }
    
    [self.delegate cascadeController:self didSelectedItem:cascadeItem];
}

#pragma mark - CHOCascadeSectionViewDelegate
- (void)sectionHeaderView:(CHOCascadeSectionView *)sectionView didSelectedCascadeItem:(id<ICHOCascadeItem>)cascadeItem {
    if ([[cascadeItem subItems] count] == 0) {
        
        if (![self.delegate respondsToSelector:@selector(cascadeController:didSelectedItem:)]) { return; }
        
        [self.delegate cascadeController:self didSelectedItem:cascadeItem];
        
        return;
    }
    NSInteger section = [self.items indexOfObject:cascadeItem];
    [cascadeItem setOpened:![cascadeItem isOpened]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}
@end
