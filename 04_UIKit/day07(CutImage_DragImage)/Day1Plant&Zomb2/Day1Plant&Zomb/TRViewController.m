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
@interface TRViewController ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *boxes;
@property (weak, nonatomic) IBOutlet UILabel *sunCountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *plantIVs;
@property (nonatomic, strong)TRPlant *dragPlant;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUI];
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
    for (UIImageView *plantIV in self.plantIVs) {
        if (CGRectContainsPoint(plantIV.frame, p)) {
            
            switch (plantIV.tag) {
                case 0:
                    self.dragPlant = [[TRSunFlower alloc]initWithFrame:plantIV.frame];
                    break;
                    
                case 1:
                    self.dragPlant = [[TRPea alloc]initWithFrame:plantIV.frame];
                    break;
                case 2:
                    self.dragPlant = [[TRIcePea alloc]initWithFrame:plantIV.frame];
                    break;
                case 3:
                    self.dragPlant = [[TRNut alloc]initWithFrame:plantIV.frame];
                    break;
            }
            [self.view addSubview:self.dragPlant];
            
        }
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self.view];
    
    self.dragPlant.center = p;
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
