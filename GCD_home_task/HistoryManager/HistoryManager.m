//
//  HistoryManager.m
//  GCD_home_task
//
//  Created by Екатерина on 11/21/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "HistoryManager.h"

@implementation HistoryManager
+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static HistoryManager* history;
    dispatch_once(&onceToken, ^{
        history = [HistoryManager new];
        history.result = [NSMutableDictionary new];
    });
    return history;
}
@end
