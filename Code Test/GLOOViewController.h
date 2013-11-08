//
//  GLOOViewController.h
//  Code Test
//
//  Created by Justin Bergen - Gloo on 11/6/13.
//  Copyright (c) 2013 Gloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLOOViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *tempField;
@property (nonatomic, weak) IBOutlet UILabel *humidityField;
@property (nonatomic, weak) IBOutlet UILabel *windSpeedField;
@property (nonatomic, weak) IBOutlet UILabel *windDirection;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *timeField;
- (IBAction)sliderChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *tempView;
@property (weak, nonatomic) IBOutlet UIView *humidityView;
@property (weak, nonatomic) IBOutlet UIView *windSpeedView;
@property (weak, nonatomic) IBOutlet UIView *windDirectionView;
- (IBAction)sliderComplete:(id)sender;
@end
