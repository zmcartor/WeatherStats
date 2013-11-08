//
//  GLOODarkSkySessionManager.m
//  Code Test
//
//  Created by Tango Pair 1 on 11/7/13.
//  Copyright (c) 2013 Gloo. All rights reserved.
//

#import "GLOODarkSkySessionManager.h"

@implementation GLOODarkSkySessionManager

+ (id)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)fetchForecastforLocation:(NSArray *)location date:(NSString *)dateString successBlock:(networkSuccessBlock)successBlock failBlock:(networkFailBlock)failblock {
    NSString *apiKey = @"38f32d237ee2f4069511303636b343a0";
    NSString *forecastString = [NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/%@,%@,%@",apiKey,@41,@81,
                                dateString];
    
    
    NSURL *forecastURL = [NSURL URLWithString:forecastString];
    NSMutableURLRequest *forecastRequest = [NSMutableURLRequest requestWithURL:forecastURL];
    [forecastRequest setHTTPMethod:@"GET"];
    [forecastRequest setValue:@"application/json" forHTTPHeaderField:@"accept"];
    
    AFJSONRequestOperation *request;
     request = [AFJSONRequestOperation JSONRequestOperationWithRequest:forecastRequest
                                                            success:successBlock
                                                            failure:failblock];
    
    [request start];
}

@end
