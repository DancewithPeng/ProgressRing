//
//  ViewController.m
//  DPProgressRingExample-ObjC
//
//  Created by 张鹏 on 2020/7/14.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import <DPProgressRing/DPProgressRing.h>

@interface ViewController ()

@property (nonatomic, strong) ProgressRing *ring;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ring = [[ProgressRing alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.ring.isClockwise = NO;
    self.ring.maximum = 4;
    self.ring.minimum = 0;
    self.ring.width = 20;
    [self.view addSubview:self.ring];
}

- (IBAction)randomButtonDidTap:(id)sender {
    self.ring.progress = arc4random()%5;
}

- (IBAction)animationRandomButtonDidTap:(id)sender {
    [self.ring setProgress:arc4random()%5 animated:YES];
}


@end
