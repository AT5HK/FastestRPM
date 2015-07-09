//
//  ViewController.h
//  FastestRPM
//
//  Created by Auston Salvana on 7/9/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *needle;
- (IBAction)panGesture:(id)sender;
@property (weak, nonatomic) IBOutlet UIPanGestureRecognizer *pan;
@end

