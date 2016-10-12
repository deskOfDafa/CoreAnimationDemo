//
//  QYkeyPathAnimationVC.m
//  02-CoreAnimationDemo
//
//  Created by qingyun on 16/10/11.
//  Copyright © 2016年 qingyun.dafa. All rights reserved.
//


#import "QYkeyPathAnimationVC.h"

#define  halfScreenWidth [UIScreen mainScreen].bounds.size.width/2.0


@interface QYkeyPathAnimationVC ()
@property(nonatomic,strong)CALayer *marioLayer;
@property(nonatomic,strong)CALayer *platformLayer;
@end

@implementation QYkeyPathAnimationVC


//1.
-(void) initLayers{
//1.构建platFormlayer;
    _platformLayer=[CALayer layer];
    _platformLayer.backgroundColor=[UIColor orangeColor].CGColor;
    //设置位置信息
    _platformLayer.bounds=CGRectMake(0, 0,halfScreenWidth, 44);
    _platformLayer.position=CGPointMake(halfScreenWidth, 200);
    _platformLayer.anchorPoint=CGPointZero;//支点在左上角 默认的中心点AnchorPoint是(0.5, 0.5) 图层的anchorPoint属性是一个CGPoint值，它指定了一个基于图层bounds的符合位置坐标系的位置。Anchor point指定了bounds相对于position的值，更重要的是，它是变换的支点。AnchorPoint值的范围是0 – 1 ，可以理解为AnchorPoint表示了支点位置的坐标占bounds的比例。

    [self.view.layer addSublayer:_platformLayer];
    
//2.构建玛丽的图册
    _marioLayer=[CALayer layer];
    _marioLayer.contents=(__bridge id _Nullable)([UIImage imageNamed:@"Mario.png"].CGImage);
    _marioLayer.contentsRect=CGRectMake(0.5, 0, .5, 1);
    _marioLayer.bounds=CGRectMake(0,0, 32, 64);
    _marioLayer.position=CGPointMake(0, self.view.frame.size.height);
    _marioLayer.anchorPoint=CGPointMake(0,1);//左下角
    [self.view.layer addSublayer:_marioLayer];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayers];
    // Do any additional setup after loading the view.
}
//2.
- (IBAction)jumpAction:(id)sender {
    //事务处理
    [CATransaction begin];
    CAKeyframeAnimation *keyAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    //2.改变Mario的状态
    _marioLayer.contentsRect=CGRectMake(0, 0, .5, 1);
    //3.构建path
    /* Create a mutable path. */
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, self.view.frame.size.height);
    //绘制曲线
    CGPathAddQuadCurveToPoint(path, NULL, 30, 140, halfScreenWidth+10, 200);
    keyAnimation.path=path;
    keyAnimation.duration=.7;
   //keyAnimation.removedOnCompletion=NO;
   // keyAnimation.fillMode=kCAFillModeForwards;
    
    //事务处理完成后调用
    [CATransaction  setCompletionBlock:^{
        //1.把动画结束
        [CATransaction setDisableActions:YES];//停止动画
        
        //2.改变Mario的状态
        //内容的矩形区域（x，y，width，height）也是绑定到层的框架上的。contentRect是一个比例值，而不是屏幕上真实的像素点。默认的是0.0,0.0,1.0,1.0.当你改变x时
        _marioLayer.contentsRect=CGRectMake(.5, 0, .5, 1);
        _marioLayer.position=CGPointMake(halfScreenWidth+10, 200);
        
        
    }];
    
    
    
    [self.marioLayer addAnimation:keyAnimation forKey:nil];
    [CATransaction  commit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
