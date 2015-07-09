//
//  ViewController.m
//  FastestRPM
//
//  Created by Auston Salvana on 7/9/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign) float time;
@property (nonatomic) NSTimer *timer;
@property (assign) CGFloat radians;
@property (assign) CGFloat degrees;
@property (nonatomic) CGAffineTransform startPostion;

@end

@implementation ViewController
{
    CGPoint startLocation;
    BOOL stop;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    stop = NO;
    self.pan.maximumNumberOfTouches = 1;
    self.radians = atan2f(self.needle.transform.b, self.needle.transform.a);
    self.degrees = self.radians * (180 / M_PI);
    
    self.startPostion = CGAffineTransformMakeRotation((140 + self.degrees) * M_PI/180);
    self.needle.transform = self.startPostion;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)incrementCounter{
    self.time += 0.01f;
    if (self.time >= 3.0) {
        self.needle.transform = self.startPostion;
        [self.timer invalidate];
        self.time = 0;
        stop = YES;
    }
}


- (IBAction)panGesture:(id)sender {
    
    
    
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer*)sender;
    CGFloat distance = 0.0;
    
    if (startLocation.x != 0.0){
        CGPoint currentLocation = [sender locationInView:self.view];
        CGFloat dx = currentLocation.x - startLocation.x;
        CGFloat dy = currentLocation.y - startLocation.y;
        distance = sqrt(dx*dx + dy*dy );
    }
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        startLocation = [sender locationInView:self.view];
        
        self.time = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(incrementCounter) userInfo:nil repeats:YES];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"time it took: %f", self.time);
        if (!stop) {

            float velocity = (float)(distance/self.time);
            [UIView animateWithDuration:1 animations:^{
                CGAffineTransform transform = CGAffineTransformRotate(self.needle.transform, (velocity + self.degrees) * M_PI/180);
                self.needle.transform = transform;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1 animations:^{
                    self.needle.transform = self.startPostion;
                }];
            }];
            [self.timer invalidate];
        }
    }
}
@end
