//
//  CollectionViewCell.h
//  GCD_home_task
//
//  Created by Екатерина on 11/19/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property(nonatomic, assign) NSString* currentIndex;


-(void) updateView:(UIImage*)newImage;
-(void)updateIndex:(NSString*)currentIndex;
@end

NS_ASSUME_NONNULL_END
