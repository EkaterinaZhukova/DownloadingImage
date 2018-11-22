//
//  StateConstants.m
//  GCD_home_task
//
//  Created by Екатерина on 11/22/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "StateConstants.h"

@implementation StateConstants
+ (NSString *)withoutDownloading{
    return @" without downloading";
}
+ (NSString *)beginConfiguration{
    return @" begin configuration";
}
+ (NSString *)downloadedAndDisplayed{
    return @" downloaded and image displayed";
}
+ (NSString *)downloadedAndNotDisplayed{
    return @" image not displayed but downloaded";
}
@end
