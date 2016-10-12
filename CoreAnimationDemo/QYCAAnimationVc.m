//
//  QYCAAnimationVc.m
//  02-CoreAnimationDemo
//
//  Created by qingyun on 16/10/11.
//  Copyright © 2016年 qingyun.dafa. All rights reserved.
//


#import "QYCAAnimationVc.h"

@interface QYCAAnimationVc ()
@property(nonatomic,strong)CALayer *layer;
@property(nonatomic,strong)CALayer *maskLayer;
@end


@implementation QYCAAnimationVc

//1.懒加载
-(CALayer *)maskLayer{

    if(_maskLayer)return _maskLayer;
    //1.初始化layer
    _maskLayer=[CALayer layer];
    _maskLayer.bounds=CGRectMake(0, 0, 200, 200);
    _maskLayer.position=CGPointMake(100, 100);
    _maskLayer.contents=(__bridge id _Nullable)([[UIImage imageNamed:@"1.png"] CGImage]);
    return _maskLayer;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //设置图层
    [self setlayer];
    
}

//2.加载图层
-(void)setlayer{
  //1.创建Calyer
    _layer=[CALayer layer];
    
  //2.设置layer属性
     _layer.backgroundColor=[UIColor blueColor].CGColor;
    _layer.cornerRadius=25;
  //3.位置信息
    _layer.bounds=CGRectMake(0, 0, 200, 200);
    _layer.position=CGPointMake(180, 320);
    
    _layer.mask=self.maskLayer;
 //4.添加到self.view.layer
    [self.view.layer addSublayer:_layer];
    
   [self addanimationForlayer:_layer];
   }

//3.给图层添加动画
-(void)addanimationForlayer:(CALayer *)tempLayer{
   //1.创建动画
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];/*虚拟属性*/
    //2设置动画属性
    animation.duration=.3;/*动画默认时间是.25s*/
    animation.toValue=@2.0;  //-setFromValue 和-setToValue 来指定一个开始值和结束值
   // animation.autoreverses=YES;//从原路径返回
 //   animation.repeatCount=HUGE_VAL;//HUGE_VAL;//重复次数 默认为0，即只播放一次
  //   animation.speed=2.0;//默认1.0的速度
    /*
     fillMode的作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO animation.autoreverses=为NO时,要不然fillMode不起作用.
     */
    animation.removedOnCompletion=NO;
     /*
     kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
     kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
     kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
     kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
     */
    animation.fillMode=kCAFillModeBackwards;//动画结束后的填充方式
     
   
    //3.动画添加到layer上
    [tempLayer addAnimation:animation forKey:nil];
    
}








@end
