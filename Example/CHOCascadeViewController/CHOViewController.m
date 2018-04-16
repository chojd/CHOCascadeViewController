//
//  CHOViewController.m
//  CHOCascadeViewController
//
//  Created by chojd on 04/15/2018.
//  Copyright (c) 2018 chojd. All rights reserved.
//

#import "CHOViewController.h"

#import <CHOCascadeViewController/CHOCascadeViewController.h>
#import <CHOCascadeViewController/CHOCascadeItem.h>

@interface CHOViewController () <CHOCascadeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *centerBtn;

@end

@implementation CHOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)handleCenterBtn:(UIButton *)sender {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (int index = 0; index < 10; index++) {
        CHOCascadeItem *item = [[CHOCascadeItem alloc] init];
        item.title = [NSString stringWithFormat:@"%d%d%d%d", index, index, index, index];
        NSMutableArray *array2 = [NSMutableArray arrayWithCapacity:10];
        for (int index1 = 0; index1 < 10; index1++) {
            CHOCascadeItem *item2 = [[CHOCascadeItem alloc] init];
            item2.title = [NSString stringWithFormat:@"%d%d%d%d", index, index, index, index];
            [array2 addObject:item2];
        }
        item.subItems = array2;
        [array addObject:item];
    }
    
    CHOCascadeViewController *vc = [[CHOCascadeViewController alloc] initWithItems:array delegate:self];
    [vc showInViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
