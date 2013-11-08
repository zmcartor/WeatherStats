//
//  GLOODarkSkySessionManager.h
//  Code Test
//
//  Created by Tango Pair 1 on 11/7/13.
//  Copyright (c) 2013 Gloo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "typedefs.h"
#import "AFNetworking.h"

@interface GLOODarkSkySessionManager : NSObject

+ (id)sharedInstance;

- (void)fetchForecastforLocation:(NSArray *)location
    date:(NSString *)dateString
    successBlock:(networkSuccessBlock)successBlock
    failBlock:(networkFailBlock)failblock;

@end
