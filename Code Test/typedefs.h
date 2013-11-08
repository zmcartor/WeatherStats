//
//  typedefs.h
//  Code Test
//
//  Created by zm on 11/7/13.
//  Copyright (c) 2013 Gloo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^networkSuccessBlock)(NSURLRequest *request, NSHTTPURLResponse *response,id JSON);
typedef void (^networkFailBlock)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON);