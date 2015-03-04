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
    [self.manager setAccelerometerUpdateInterval:1.0/40];
    //开始更新
    [self.manager startAccelerometerUpdates];
    [NSTimer scheduledTimerWithTimeInterval:1.0/40 target:self selector:@selector(updateInfo) userInfo:Nil repeats:YES];
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
    //判断碰到左边
    if (self.myBall.frame.origin.x<=0) {
        self.oldX = -self.oldX/2;
        frame.origin.x = 0;
    }
    //碰右边
    if (self.myBall.frame.origin.x>=320-self.myBall.frame.size.width){
        self.oldX = -self.oldX/2;
        frame.origin.x = 320-self.myBall.frame.size.width;
    }
    //碰上边
    if (self.myBall.frame.origin.y<=0){
        self.oldY = -self.oldY/2;
        frame.origin.y = 0;
    }
//碰下边
    if (self.myBall.frame.origin.y>=460-self.myBall.frame.size.height){
        self.oldY = -self.oldY/2;
        frame.origin.y = 460-self.myBall.frame.size.height;
    }
     self.myBall.frame = frame;
    
    
    
    //碰撞检测
    for (UIView *wall in self.walls) {
        if (CGRectIntersectsRect(wall.frame, self.myBall.frame)) {
            
            if (wall.tag==0) {
                //死掉了
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"恭喜你 死掉了！！！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [av show];
                
               
            }else{
                //过关
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"哈哈 过关了！！！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [av show];
            }
             [self.myBall removeFromSuperview];
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
