//
//  TRViewController.m
//  Day1Plant&Zomb
//
//  Created by tarena on 14-4-9.
//  Copyright (c) 2014年 tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRSunFlower.h"
#import "TRPea.h"
#import "TRIcePea.h"
#import "TRNut.h"
#import "TRZomb.h"
#import "TRZombA.h"
#import "TRZombB.h"
#import "TRZombC.h"
#import "TRZombD.h"
@interface TRViewController ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *boxes;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *plantIVs;
@property (nonatomic, strong)TRPlant *dragPlant;
@property (nonatomic)int zombCount;
@property (nonatomic, strong)NSMutableArray *zombs;
@property (nonatomic, strong)NSMutableArray *plants;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    self.zombs = [NSMutableArray array];
    self.plants = [NSMutableArray array];
    [super viewDidLoad];
	[self initUI];
    
    //添加僵尸
    [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(beginAddZomb) userInfo:Nil repeats:NO];
    
    //碰撞检测
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(pengZhuang) userInfo:Nil repeats:YES];
}
-(void)pengZhuang{
    
    for (TRZomb *zomb in self.zombs) {
        for (TRPlant *plant in self.plants) {
            
            if (plant.tag==1||plant.tag ==2) {
                TRPea *pea = (TRPea*)plant;
                for (UIImageView *bulletIV in pea.bullets) {
                    
                    if (CGRectIntersectsRect(zomb.frame, bulletIV.frame)) {
                    //如果条件满足说明子弹打到僵尸了
                        
                        zomb.HP--;
                        if (zomb.HP<=0) {
                            [zomb removeFromSuperview];
                            [self.zombs removeObject:zomb];
                        }
                        [bulletIV removeFromSuperview];
                        [pea.bullets removeObject:bulletIV];
                        
                        return;
                    }
                    
                    
                }
                
            }
            
            
        }
    }
    
}
-(void)beginAddZomb{
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(addZombAction) userInfo:Nil repeats:YES];
}

-(void)addZombAction{
    
//    1-20  A
//    21-40  B
//    ...
   
    int x = self.zombCount/30;
    TRZomb *zomb = Nil;
    switch (x) {
        case 0://A
            zomb = [[TRZombA alloc]init];
            break;
            
        case 1://B
            zomb = [[TRZombB alloc]init];
            break;
        case 2://C
            zomb = [[TRZombC alloc]init];
            break;
        case 3://D
            zomb = [[TRZombD alloc]init];
            break;
    }
    
    zomb.frame = CGRectMake(568, arc4random()%5*50+50, 30, 50);
    
    [self.view addSubview:zomb];
   
    [self.zombs addObject:zomb];
   
   self.zombCount++;
}
-(void)initUI{
    UIImage *plantsImage = [UIImage imageNamed:@"seedpackets.png"];
    
    for (int i=0; i<self.plantIVs.count; i++) {
        UIImageView *plantIV = self.plantIVs[i];
        int x = 0;
        switch (i) {
            case 0://向日葵
                x = 0;
                break;
            case 1://豌豆射手
                x = 2;
                break;
            case 2://寒冰射手
                x = 3;
                break;
            case 3://坚果
                x = 5;
                break;
        }
        
        CGImageRef subImage = CGImageCreateWithImageInRect(plantsImage.CGImage, CGRectMake(x*plantsImage.size.width/18, 0, plantsImage.size.width/18, plantsImage.size.height));
        plantIV.image = [UIImage imageWithCGImage:subImage];
        CGImageRelease(subImage);
        
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self.view];
    
    int currentSunCount = self.sunCountLabel.text.intValue;
    
    for (UIImageView *plantIV in self.plantIVs) {
        if (CGRectContainsPoint(plantIV.frame, p)&& plantIV.alpha == 1) {
            
            switch (plantIV.tag) {
                case 0:
                    if (currentSunCount<50) {
                        return;
                    }
                    self.dragPlant = [[TRSunFlower alloc]initWithFrame:plantIV.frame];
                   
                    break;
                    
                case 1:
                    if (currentSunCount<100) {
                        return;
                    }
                    self.dragPlant = [[TRPea alloc]initWithFrame:plantIV.frame];
                    break;
                case 2:
                    if (currentSunCount<175) {
                        return;
                    }
                    self.dragPlant = [[TRIcePea alloc]initWithFrame:plantIV.frame];
                    break;
                case 3:
                    if (currentSunCount<100) {
                        return;
                    }
                    self.dragPlant = [[TRNut alloc]initWithFrame:plantIV.frame];
          
                    break;
            }
            //用来区分植物
             self.dragPlant.tag = plantIV.tag;
            self.dragPlant.vc = self;
            [self.view addSubview:self.dragPlant];
            
        }
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self.view];
    
    self.dragPlant.center = p;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self.view];
    
    if (self.dragPlant) {
        for (UIView *box in self.boxes) {
            if (CGRectContainsPoint(box.frame, p) && box.subviews.count==0) {//条件满足的话 就扔进这个坑里面
                
                
                UIImageView *plantIV = self.plantIVs[self.dragPlant.tag];
                plantIV.alpha = .5;
                
                
                [box addSubview:self.dragPlant];
                self.dragPlant.center = CGPointMake(box.bounds.size.width/2, box.bounds.size.height/2);
                [self.dragPlant fire];
               
                [self.plants addObject:self.dragPlant];
               
               int costSunCount = 0;
                int resetTime = 0;
                //花钱
                switch (self.dragPlant.tag) {
                    case 0:
                        resetTime = 2;
                        costSunCount = 50;
                        break;
                    case 1:
                        resetTime = 3;
                        costSunCount = 100;
                        break;
                    case 2:
                        resetTime = 4;
                        costSunCount = 175;
                        break;
                    case 3:
                        resetTime = 5;
                        costSunCount = 100;
                        break;
                }
                [NSTimer scheduledTimerWithTimeInterval:resetTime target:self selector:@selector(resetStatus:) userInfo:plantIV repeats:NO];
                self.sunCountLabel.text = [NSString stringWithFormat:@"%d",self.sunCountLabel.text.intValue - costSunCount];
            }
        }
       
        //判断如果没有在任何一个坑里面松手 删除之
        if ([self.dragPlant.superview isEqual:self.view]) {
            [self.dragPlant removeFromSuperview];
        }
        self.dragPlant = nil;
        
    }
    
    
}

-(void)resetStatus:(NSTimer *)timer{
    UIImageView *plantIV = timer.userInfo;
    plantIV.alpha = 1;
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.dragPlant) {
        [self.dragPlant removeFromSuperview];
    }
}
//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
