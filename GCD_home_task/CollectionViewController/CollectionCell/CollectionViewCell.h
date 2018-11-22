//
//  CollectionViewCell.h
//  GCD_home_task
//
//  Created by Екатерина on 11/19/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSDate(MyOwnFormatterMethod)
+(NSDate*)cuurentDateInFormat;
@end
@interface CollectionViewCell : UICollectionViewCell
@property(nonatomic, assign) NSString* currentIndex;
@property(nonatomic, strong) NSURL* currentURL;
@property(nonatomic, weak)NSBlockOperation* block;


-(void) updateView:(UIImage*)newImage :(NSURL*)url;
-(void)updateIndex:(NSString*)currentIndex;
-(BOOL)isImageSetUp;
-(void)updateCurrentUrl:(NSURL*)newUrl;
@end
NS_ASSUME_NONNULL_END
