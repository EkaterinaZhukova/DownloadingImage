//
//  HistoryManager.h
//  GCD_home_task
//
//  Created by Екатерина on 11/21/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StateConstants.h"
NS_ASSUME_NONNULL_BEGIN

@interface HistoryManager : NSObject
+(instancetype)shared;
-(void) writeToResultDictionary :(NSString*)state :(NSInteger)currentIndex;
@property(nonatomic,strong)NSMutableDictionary* result;
@end

NS_ASSUME_NONNULL_END
