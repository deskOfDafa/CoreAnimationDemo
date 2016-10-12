//
//  QYGroupAnimationVC.m
//  02-CoreAnimationDemo
//
//  Created by qingyun on 16/10/11.
//  Copyright © 2016年 qingyun.dafa. All rights reserved.
//


#import "QYGroupAnimationVC.h"

@interface QYGroupAnimationVC ()
@property(nonatomic,strong)CALayer *maskLayer;
@property(nonatomic,strong)CALayer *layer;
@end




@implementation QYGroupAnimationVC


//1.
-(CALayer *)maskLayer{
    if (_maskLayer) {
        return _maskLayer;
    }
    
    //1.初始化
    _maskLayer=[CALayer layer];
    _maskLayer.contents=(__bridge id _Nullable)([UIImage imageNamed:@"1.png"].CGImage);
    _maskLayer.bounds=CGRectMake(0, 0, 200, 200);
    _maskLayer.position=CGPointMake(100, 100);

    return _maskLayer;
}

//2.
-(void)setLayer{
  //1.初始化layer
    _layer=[CALayer layer];
  //2.设置layer属性
    _layer.backgroundColor=[[UIColor grayColor] CGColor];
  //3.设置layer位置信息
    _layer.bounds=CGRectMake(0, 0, 200, 200);
    _layer.position=CGPointMake(180, 320);
  //4.masklayer
    _layer.mask=self.maskLayer;

  //5.添加到当前视图的layer上
    [self.view.layer addSublayer:_layer];
    
  //6.给layer添加动画效果
    [self addAnimationForLayer:_layer];
    
}
//3.
-(void)addAnimationForLayer:(CALayer *)tempLayer{
  //1.scale
    CABasicAnimation *scaleAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration=1.5;
    scaleAnimation.toValue=@1.2;
    //多少秒之后动画才开始
    scaleAnimation.fillMode=kCAFillModeForwards;
  //  scaleAnimation.beginTime=.5;
    
  //2.rotation  顺时针方向
    CABasicAnimation *rotationAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.duration=1.2;
    rotationAnimation.toValue=@M_PI_2;
    //动画执行完毕后最后的状态
    rotationAnimation.fillMode=kCAFillModeForwards;
    //多少秒之后动画才开始
   // rotationAnimation.beginTime=.8;
    
  //3.backgroundColor 颜色
    CABasicAnimation *backGroudCaniamtion=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backGroudCaniamtion.duration=2;
    backGroudCaniamtion.toValue=(__bridge id _Nullable)([UIColor redColor].CGColor);
    
    
  //4.初始化动画组
    CAAnimationGroup *groupAnimation=[CAAnimationGroup animation];
    groupAnimation.animations=@[scaleAnimation,backGroudCaniamtion,rotationAnimation];
    //设置重复次数,时间，原路径返回
    groupAnimation.repeatCount=HUGE_VAL;
    groupAnimation.duration=2;
    groupAnimation.autoreverses=YES; //原路返回
    
  //5.动画添加到layer上
    [tempLayer addAnimation:groupAnimation forKey:nil];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayer];
    // Do any additional setup after loading the view.
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
