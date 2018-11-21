//
//  CollectionViewCell.m
//  GCD_home_task
//
//  Created by Екатерина on 11/19/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Masonry.h"

@interface CollectionViewCell()
@property(nonatomic, retain) UIImageView *imageView;
@property(nonatomic, retain) UILabel* loadingLabel;
@property(nonatomic, retain) UILabel* indexLabel;
@property(nonatomic, assign) UIImage* image;
@end

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf = self;

        
        UILabel* labelIndex = [[UILabel alloc]init];
        labelIndex.text = @"index";
        labelIndex.textColor = UIColor.blackColor;
        labelIndex.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:labelIndex];
        self.indexLabel = labelIndex;
        [labelIndex mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top);
            make.left.equalTo(weakSelf.contentView.mas_left);
            make.width.equalTo(weakSelf.contentView.mas_width);
            make.height.equalTo(@50);
        }];
        
        
        UIImageView *view = [[UIImageView alloc]init];
        
        [view setContentMode:UIViewContentModeScaleToFill];
        UILabel* label = [[UILabel alloc]init];
        label.text = @"loading";
        label.textColor = UIColor.blackColor;
        label.textAlignment = NSTextAlignmentCenter;
        self.loadingLabel = label;
        
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.width.equalTo(weakSelf.contentView.mas_width);
            make.height.equalTo(@50);
        }];
        
        self.imageView = view;
        [self.contentView addSubview:self.imageView];

        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).with.offset(50);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom);
            make.width.equalTo(weakSelf.contentView.mas_width);
        }];
        
        NSLog(@"init cell");
    }
    return self;
}
-(void) updateView:(UIImage*)newImage{
    self.imageView.image = newImage;
}
-(void)updateIndex:(NSString*)currentIndex{
    self.indexLabel.text = currentIndex;
}
- (void)dealloc
{
    NSLog(@"Cell dealloced");
}
- (void)prepareForReuse{
    self.imageView.image = NULL;
    self.indexLabel.text = @"index";
}
@end
