//
//  GLOOViewController.m
//  Code Test
//
//  Created by Justin Bergen - Gloo on 11/6/13.
//  Copyright (c) 2013 Gloo. All rights reserved.
//

#import "GLOOViewController.h"
#import "GLOODarkSkySessionManager.h"

@interface GLOOViewController (){
    NSDateFormatter *dateFormatter;
    NSMutableDictionary *cachedTimes;
    NSString *todaysDate;
}
@end


@implementation GLOOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.slider.maximumValue = 24;
    self.slider.minimumValue = 0;
    self.activityIndicator.hidesWhenStopped = YES;
    cachedTimes = [[NSMutableDictionary alloc] init];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'";
    todaysDate = [dateFormatter stringFromDate:[NSDate date]];
    
    
    dateFormatter.dateFormat = @"HH";
    NSString *now = [dateFormatter stringFromDate:[NSDate date]];
    self.slider.value = [now integerValue];
    self.timeField.text = [NSString stringWithFormat:@"%@:00", now];
}

- (void) viewDidAppear:(BOOL)animated {
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'";
    todaysDate = [dateFormatter stringFromDate:[NSDate date]];
    
    dateFormatter.dateFormat = @"HH";
    NSString *now = [dateFormatter stringFromDate:[NSDate date]];
    self.slider.value = [now integerValue];
    self.timeField.text = [NSString stringWithFormat:@"%@:00", now];
    [self fetchWeatherDataFromNetworkForHour:now];
}

- (void) updateInterfaceWithArray:(NSArray *)properties {
    self.tempField.text = [NSString stringWithFormat:@"%@ F", properties[0]];
    self.humidityField.text = [NSString stringWithFormat:@"%@ %%", properties[1]];
    self.windSpeedField.text = [NSString stringWithFormat:@"%@", properties[2]];
    self.windDirection.text = [NSString stringWithFormat:@"%@", properties[3]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderChanged:(UISlider *)sender {
    NSString *hourString = [NSString stringWithFormat:@"%i", (int)sender.value];
    self.timeField.text = [NSString stringWithFormat:@"%@:00", hourString];
}
    
- (IBAction)sliderComplete:(UISlider *)sender {
    // TODO , there is a cache miss if the starting value is missing trailing '0'
    NSString *hourString = [NSString stringWithFormat:@"%i", (int)self.slider.value];
    if ([cachedTimes objectForKey:hourString]){
        NSLog(@"CACHE HIT!");
        [self updateInterfaceWithArray: [cachedTimes objectForKey:hourString] ];
        return;
    }
    [self.activityIndicator startAnimating];
    [self fetchWeatherDataFromNetworkForHour:hourString];
}

- (void) fetchWeatherDataFromNetworkForHour:(NSString *)hour{
    typeof(self) __block blockself = self;
    __block NSArray *properties;
   
    NSLog(@"CACHE MISS!");
    networkSuccessBlock success = ^(NSURLRequest *request, NSHTTPURLResponse *response,id JSON){
        NSDictionary *currently = [JSON objectForKey:@"currently"];
        properties = @[ [NSString stringWithFormat:@"%@", currently[@"temperature"]], [NSString stringWithFormat:@"%@", currently[@"humidity"]], [NSString stringWithFormat:@"%@", currently[@"windBearing"]], [NSString stringWithFormat:@"%@" ,currently[@"windSpeed"]] ];
        
        [cachedTimes setObject:properties forKey:hour];
        [blockself updateInterfaceWithArray:properties];
        [blockself.activityIndicator stopAnimating];
    };
    
    networkFailBlock failure = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Weather Unavailable"
                                                          message:@"Sorry, weather data not available"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [self.activityIndicator stopAnimating];
    };
    
    if ([hour length] ==1){
        hour = [NSString stringWithFormat:@"0%@", hour];
    }
  
     // yyyy-MM-dd'T'HH:mm
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'";
    NSString *fulldate = [NSString stringWithFormat:@"%@%@:00:00", todaysDate, hour];
    GLOODarkSkySessionManager *session = [GLOODarkSkySessionManager sharedInstance];
    [session fetchForecastforLocation:@[@41,@81] date:fulldate successBlock:success failBlock:failure];
}
    
@end
