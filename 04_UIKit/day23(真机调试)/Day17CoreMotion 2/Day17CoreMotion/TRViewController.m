//
//  TRViewController.m
//  Day17CoreMotion
//
//  Created by tarena on 14-5-4.
//  Copyright (c) 2014年 tarena. All rights reserved.
//

#import "TRViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIButton *myBall;
@property (nonatomic ,strong)CMMotionManager *manager;
@property (nonatomic)float oldX;
@property (nonatomic)float oldY;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	 
    self.manager = [[CMMotionManager alloc]init];
    //设置更新频率
    [self.manager setAccelerometerUpdateInterval:1.0/30];
    //开始更新
    [self.manager startAccelerometerUpdates];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(updateInfo) userInfo:Nil repeats:YES];
}

// -1
// 1 2 3 4 3 2 1 0 -1 -2 -3
-(void)updateInfo{
    //获取重力感应数据
    CMAcceleration acc = self.manager.accelerometerData.acceleration;
    self.oldX = self.oldX + acc.x;
    self.oldY = self.oldY + acc.y;
    self.myBall.center = CGPointMake(self.myBall.center.x+self.oldX, self.myBall.center.y-self.oldY);
    //添加墙
       CGRect frame = self.myBall.frame;
    if (self.myBall.frame.origin.x<=0) {
     
        frame.origin.x = 0;
       
    }else if (self.myBall.frame.origin.x>=320-self.myBall.frame.size.width){
 
        frame.origin.x = 320-self.myBall.frame.size.width;
    }else if (self.myBall.frame.origin.y<=0){
 
        frame.origin.y = 0;

    }else if (self.myBall.frame.origin.y>=460-self.myBall.frame.size.height){
 
        frame.origin.y = 460-self.myBall.frame.size.height;
   
    }
     self.myBall.frame = frame;
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
