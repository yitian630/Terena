//
//  TRViewController.m
//  Day13CoreData
//
//  Created by tarena on 14-4-26.
//  Copyright (c) 2014年 tarena. All rights reserved.
//

#import "TRViewController.h"
#import "Person.h"
#import "TRAppDelegate.h"
@interface TRViewController ()

- (IBAction)clicked:(UIButton *)sender;

@end

@implementation TRViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"%@",NSHomeDirectory());
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clicked:(UIButton *)sender {
    //从任意位置通过
    TRAppDelegate *app = [UIApplication sharedApplication].delegate;
    
    switch (sender.tag) {
        case 0://增
        {
            Person *p = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:app.managedObjectContext];
            p.name = @"小王";
            p.age = @35;
            p.phoneNumber = @"13838383388";
            //最后要保存
            [app saveContext];
        }
            break;
        case 1://删
            
            break;
        case 2://改
            
            break;
        case 3://查
        {
            //创建一个查询请求
            NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
            //执行查询请求得到结果 数组
            NSArray *persons = [app.managedObjectContext executeFetchRequest:request error:Nil];
            for (Person *p in persons) {
                NSLog(@"%@  %@ %@",p.name,p.age,p.phoneNumber);
            }
            
            
        }
            break;
    }
}
@end
