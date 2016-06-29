//
//  FISViewController.m
//  theFinalCountdown
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSTimer *selectedTimerBasedOnDatePicker;
@property (strong, nonatomic) NSDate *dateAtStartOfTimer;
@property (strong, nonatomic) NSDate *dateOfEndOfTimer;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)resetTimer {
    [self.selectedTimerBasedOnDatePicker invalidate];
    self.datePicker.hidden = NO;
    self.timeLabel.hidden = YES;
    self.startButton.hidden = NO;
    self.cancelButton.hidden = YES;
}

- (void)updateTimeLabelText {
    NSTimeInterval timeSinceStartOfTimer = [self.dateAtStartOfTimer timeIntervalSinceNow];
    NSDateComponentsFormatter *countDownText = [[NSDateComponentsFormatter alloc] init];
    self.timeLabel.text = [countDownText stringFromTimeInterval:timeSinceStartOfTimer];
    if (self.dateAtStartOfTimer.timeIntervalSinceNow <= 0) {
        [self resetTimer];
    }
}

- (IBAction)startButtonTapped:(id)sender {
    
    //stores time picked as an NSDate, creates a timer and set label to selected time
    self.dateAtStartOfTimer = [NSDate dateWithTimeIntervalSinceNow:self.datePicker.countDownDuration];
    self.selectedTimerBasedOnDatePicker = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimeLabelText) userInfo:nil repeats:YES];
    [self updateTimeLabelText];
    
    //hides date picker and shows countdown label
    self.datePicker.hidden = YES;
    self.timeLabel.hidden = NO;
    self.startButton.hidden = YES;
    self.cancelButton.hidden = NO;
    
}

- (IBAction)pauseButtonTapped:(id)sender {
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self resetTimer];
}

@end
