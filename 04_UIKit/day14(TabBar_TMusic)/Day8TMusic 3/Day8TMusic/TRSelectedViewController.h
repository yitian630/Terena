//
//  TRSelectedViewController.h
//  TMusic
//
//  Created by Alex Zhao on 13-8-8.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRSelectedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mySubSV;
 
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSArray * channels;

@end
