//
//  ResultViewController.m
//  GCD_home_task
//
//  Created by Екатерина on 11/21/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "ResultViewController.h"
#import "Masonry.h"
#import "HistoryManager.h"
#define tableViewReusableCell @"tableViewCell"
@interface ResultViewController ()
@property(nonatomic,assign)NSArray* arr;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
    HistoryManager* manager = HistoryManager.shared;
    self.arr = [manager getArrayForKey:self.index];
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchDown];
    
    UITableView* tableView = [[UITableView alloc]init];
    [tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:tableViewReusableCell];
    tableView.dataSource = self;
    
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
@interface ResultViewController(AddTableViewDataSource)<UITableViewDataSource>

@end
@implementation ResultViewController(AddTableViewDataSource)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tableViewReusableCell forIndexPath:indexPath];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arr count];
}

@end
