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
@property (strong, nonatomic) NSTimer *activeTimer;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *timerEndDate;
@property (strong, nonatomic) NSDate *pauseDate;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *resumeButton;

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
    self.datePicker.hidden = NO;
    self.timeLabel.hidden = YES;
    self.startButton.hidden = NO;
    self.cancelButton.hidden = YES;
}

- (void)updateTimeLabelText {
    NSTimeInterval timeSinceStartOfTimer = [self.timerEndDate timeIntervalSinceNow];
    NSDateComponentsFormatter *countDownText = [[NSDateComponentsFormatter alloc] init];
    self.timeLabel.text = [countDownText stringFromTimeInterval:timeSinceStartOfTimer];
    if (self.timerEndDate.timeIntervalSinceNow <= 0) {
        [self.activeTimer invalidate];
        [self resetTimer];
    }
}

- (void)startTimer:(NSDate *)fireDate {
    self.timerEndDate = fireDate;
    NSTimer *countDownTimer = [[NSTimer alloc] init];
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimeLabelText) userInfo:nil repeats:YES];
    self.activeTimer = countDownTimer;
}

- (IBAction)startButtonTapped:(id)sender {
    
    //start timer
    [self startTimer:[NSDate dateWithTimeIntervalSinceNow:self.datePicker.countDownDuration]];
    self.startDate = [NSDate date];
    
    //hides date picker and shows countdown label
    self.datePicker.hidden = YES;
    self.timeLabel.hidden = NO;
    self.startButton.hidden = YES;
    self.cancelButton.hidden = NO;
    self.pauseButton.enabled = YES;
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self resetTimer];
}



- (IBAction)pauseButtonTapped:(id)sender {
    [self.activeTimer invalidate];
    self.pauseDate = [NSDate date];
    self.pauseButton.hidden = YES;
    self.pauseButton.enabled = NO;
    self.resumeButton.hidden = NO;
    //self.pauseButton.titleLabel.text = @"Resume";
}

- (IBAction)resumeButtonTapped:(id)sender {
    NSTimeInterval timeRemaining = [self.startDate timeIntervalSinceDate:self.pauseDate];
    timeRemaining = self.datePicker.countDownDuration + timeRemaining;
    NSDate *resumeDate = [NSDate dateWithTimeIntervalSinceNow:timeRemaining];
    [self startTimer:resumeDate];
    self.pauseButton.hidden = NO;
    self.resumeButton.hidden = YES;
    self.resumeButton.enabled = NO;
}

@end
