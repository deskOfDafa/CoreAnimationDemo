//
//  QYCatranstionVC.m
//  02-CoreAnimationDemo
//
//  Created by qingyun on 16/10/11.
//  Copyright © 2016年 qingyun.dafa. All rights reserved.
//


#import "QYCatranstionVC.h"

@interface QYCatranstionVC ()
@property(nonatomic,strong)CALayer *baseLayer;
@property(nonatomic,strong)CALayer *readLayer;
@property(nonatomic,strong)CALayer *blueLayer;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegmented;
@property (weak, nonatomic) IBOutlet UISegmentedControl *subTypeSegmented;

@end

@implementation QYCatranstionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.初始化baseLayer
    _baseLayer=[CALayer layer];
    _baseLayer.bounds=CGRectMake(0, 0, 180, 180);
    _baseLayer.position=CGPointMake(180, 340);
    [self.view.layer addSublayer:_baseLayer];
    
    //2.初始化readLayer
    _readLayer=[CALayer layer];
    _readLayer.backgroundColor=[UIColor redColor].CGColor;
    _readLayer.bounds=CGRectMake(0, 0, 180, 180);
    _readLayer.position=CGPointMake(90, 90);
    _readLayer.hidden=YES;
    [_baseLayer addSublayer:_readLayer];
    
    //3.添加blueLayer
    _blueLayer=[CALayer layer];
    _blueLayer.backgroundColor=[UIColor blueColor].CGColor;
    _blueLayer.bounds=CGRectMake(0, 0, 180, 180);
    _blueLayer.position=CGPointMake(90, 90);
    _blueLayer.hidden=NO;
    
    [_baseLayer addSublayer:_blueLayer];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TrastionAction:(id)sender {
    //1.初始化动画
    CATransition *transistion=[CATransition animation];
    //2.几种动画样式
    NSArray *typeArr=@[kCATransitionFade,kCATransitionMoveIn,kCATransitionPush,kCATransitionReveal];
    NSArray *subTypeArr=@[kCATransitionFromRight,kCATransitionFromLeft,kCATransitionFromTop,kCATransitionFromBottom];
    //3.设置type、subtype
    transistion.type=typeArr[_typeSegmented.selectedSegmentIndex];
    transistion.subtype=subTypeArr[_subTypeSegmented.selectedSegmentIndex];
    //4.添加动画
    [_baseLayer addAnimation:transistion forKey:nil];
    
    _readLayer.hidden=!_readLayer.hidden;
    _blueLayer.hidden=!_blueLayer.hidden;
 
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
