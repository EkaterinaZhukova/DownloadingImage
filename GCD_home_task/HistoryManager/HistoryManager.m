//
//  HistoryManager.m
//  GCD_home_task
//
//  Created by Екатерина on 11/21/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "HistoryManager.h"
#import "CollectionViewCell.h"
@interface HistoryManager()
@property(nonatomic,retain)dispatch_queue_t queue;
@end
@implementation HistoryManager
+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static HistoryManager* history;
    dispatch_once(&onceToken, ^{
        history = [HistoryManager new];
        history.result = [NSMutableDictionary new];
        history.queue = dispatch_queue_create(".serial.shared.history.manager", DISPATCH_QUEUE_SERIAL);
    });
    return history;
}

-(void)writeToResultDictionary :(NSString *)state :(NSInteger)currentIndex{
    HistoryManager* current = [HistoryManager shared];
    __weak typeof(current) weakCurrent = current;
    dispatch_sync(current.queue, ^{
        NSString *index = [NSString stringWithFormat:@"%ld",currentIndex];
        NSString* str = [[NSString stringWithFormat:@"%@",[NSDate cuurentDateInFormat]] stringByAppendingString:state];
        if(weakCurrent.result[index] == NULL){
            [weakCurrent.result setObject:[[NSMutableArray alloc]init] forKey:index];
        }
        [weakCurrent.result[index] addObject:str];
    });

  
}
@end
