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

@property(nonatomic,strong)NSMutableDictionary* result;
@property(nonatomic,retain)dispatch_queue_t queue;
@property(nonatomic,strong)NSLock* lock;

@end
@implementation HistoryManager
+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static HistoryManager* history;
    dispatch_once(&onceToken, ^{
        history = [HistoryManager new];
        history.result = [NSMutableDictionary new];
        //history.queue = dispatch_queue_create(".serial.shared.history.manager", DISPATCH_QUEUE_SERIAL);
        history.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    });
    return history;
}

-(void)writeToResultDictionary :(NSString *)state :(NSInteger)currentIndex{
    HistoryManager* current = [HistoryManager shared];
    __weak typeof(current) weakCurrent = current;
    dispatch_async(current.queue, ^{
        dispatch_sync(weakCurrent.queue, ^{
            NSString *index = [NSString stringWithFormat:@"%ld",currentIndex];
            NSString* str = [[NSString stringWithFormat:@"%@",[NSDate cuurentDateInFormat]] stringByAppendingString:state];
            [weakCurrent.lock lock];
            if(weakCurrent.result[index] == NULL){
                [weakCurrent.result setObject:[[NSMutableArray alloc]init] forKey:index];
            }
            [weakCurrent.result[index] addObject:str];
            [weakCurrent.lock unlock];
        });
    });
}

- (NSDictionary *)getDictionary{
    HistoryManager* current = [HistoryManager shared];
    NSDictionary* resultDistionatr;
    [current.lock lock];
    resultDistionatr = current.result;
    [current.lock unlock];
    return resultDistionatr;
}
-(NSArray*)getArrayForKey :(NSString*)key{
    NSArray* resultArray;
    HistoryManager* current = [HistoryManager shared];
    [current.lock lock];
    resultArray = current.result[key];
    [current.lock unlock];
    return resultArray;
}
@end
