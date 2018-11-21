//
//  ResultViewController.m
//  GCD_home_task
//
//  Created by Екатерина on 11/21/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "ResultViewController.h"
#import "Masonry.h"
@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
    [self.view setBackgroundColor:UIColor.whiteColor];
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchDown];
    
    UITableView* tableView = [[UITableView alloc]init];
    tableView.backgroundColor = UIColor.redColor;
    [self.view addSubview:closeButton];
    [self.view addSubview:tableView];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(closeButton.mas_bottom);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
}
-(void) closeView{
    self.onCloseAction();
}
- (void)dealloc{
    NSLog(@"Dealloc ResultViewCOntroller");
}
@end
