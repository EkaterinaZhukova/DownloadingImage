//
//  ViewController.m
//  GCD_home_task
//
//  Created by Екатерина on 11/19/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "CollectionImageViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * showNewControllerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    showNewControllerButton.backgroundColor = UIColor.blueColor;
    showNewControllerButton.tintColor = UIColor.whiteColor;
    [showNewControllerButton setTitle:@"show" forState:UIControlStateNormal];
    
    [showNewControllerButton addTarget:self action:@selector(showNewViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showNewControllerButton];
    __weak typeof(self) weakSelf = self;
    [showNewControllerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
}
- (void) showNewViewController{
    CollectionImageViewController *toPresentVC = [[CollectionImageViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    toPresentVC.onCloseAction = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:toPresentVC animated:YES];
    
}
- (void)dealloc
{
    NSLog(@"Dealloc VIewController");
}

@end
