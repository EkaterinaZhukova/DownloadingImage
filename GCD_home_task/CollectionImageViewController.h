//
//  CollectionImageViewController.h
//  GCD_home_task
//
//  Created by Екатерина on 11/19/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionImageViewController : UIViewController
@property(nonatomic,copy) dispatch_block_t onCloseAction;
@end

NS_ASSUME_NONNULL_END
