//
//  ViewController.m
//  CALayer
//
//  Created by apple on 2016/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 在iOS中，你能看得见摸得着的东西基本上都是UIView，比如一个按钮、一个文本标签、一个文本输入框、一个图标等等，这些都是UIView；
 其实UIView之所以能显示在屏幕上，完全是因为它内部的一个图层(layer)；
 在创建UIView对象时，UIView内部会自动创建一个图层(即CALayer对象)，通过UIView的layer属性可以访问这个图层；
 与UIImageView控件不同，UIView内部只有一个层，即主层，而没有内容层；
 当UIView需要显示到屏幕上时，系统会调用"drawRect:"方法进行绘图，并且会将所有内容绘制在自己的图层上，绘图完毕后，系统会将图层拷贝到屏幕上，于是就完成了UIView的显示。换句话说，UIView本身不具备显示功能，是它内部的图层才有显示的功能。
 
 与UIView不同，UIImageView控件内部有两个层，即主层和内容层，主层在下，内容层在上；
 当UIImageView控件需要显示到屏幕上时，系统会将图片的内容绘制在内容层上，绘制完毕后主层和内容层都将拷贝到屏幕上，于是就完成了UIImageView控件的显示。换句话说，UIImageView控件本身不具备显示功能，是它内部的内容层才有显示的功能。
 */
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test];
//    [self test1];
}

#pragma mark ————— UIView —————
- (void)test
{
    //设置UIView的边框宽度
    self.redView.layer.borderWidth = 10;
    
    //设置UIView的边框颜色
    self.redView.layer.borderColor = [UIColor blueColor].CGColor;
    
    //设置UIView的边框的圆角半径
    self.redView.layer.cornerRadius = 10;
    
    //设置UIView的阴影颜色
    self.redView.layer.shadowColor = [UIColor greenColor].CGColor;
    
    /**
     设置UIView的阴影偏差：
     CGSizeMake里面的width参数如果为正数的话则表示阴影向UIView的右边偏离，如果为负数的话则表示向左边偏离。height参数如果为正数的话则表示阴影向UIView的下边偏离，如果为负数的话则表示向上边偏离。
     */
    self.redView.layer.shadowOffset = CGSizeMake(20, 20);
    
    //设置UIView的阴影的不透明度
    self.redView.layer.shadowOpacity = 0.5;
    
    //设置UIView的阴影的圆角半径
    self.redView.layer.shadowRadius = 10;
    
    //可以通过图层(layer)的contents属性得知UIView是否具有内容层。
    NSLog(@"%@", self.redView.layer.contents);
}

#pragma mark ————— UIImageView —————
/**
 UIImageView控件内部有两个层，即主层和内容层，主层在下，内容层在上。利用"self.imageView.layer"语句获取到的只是控件的主层，而图片是绘制在控件的内容层上的，所以"self.imageView.layer.cornerRadius"语句只能设置主层的圆角半径，并不能设置内容层的圆角半径，所以对显示在内容层上的图片也不起任何作用。正确的做法应该是先用"self.imageView.layer.cornerRadius"语句来设置主层的圆角半径，然后再撰写"self.imageView.layer.masksToBounds = YES"语句，用来把超出主层的范围全部裁切掉，这样的话内容层就有圆角了，所以绘制在内容层上的图片也就有了圆角；
 如果UIImageView控件是正方形，则可以使用如下的方法把控件由正方形变成圆形，也可以使用Quartz2D的方法把图片由正方形裁剪成圆形。如果UIImageView控件是长方形的话则不能使用如下的方法把控件由长方形变成圆形或椭圆形，但是可以使用Quartz2D的方法把图片由长方形裁剪成椭圆形；
 下面的方法与用Quartz2D裁剪图片的方法相比，下面的方法是在改变UIImageView控件，而Quartz2D的方法是在裁剪图片，而且用下面的方法把图片由正方形变为圆形之后，有时候图片的边缘会出现锯齿，所以想让图片由正方形变成圆形的话首先推荐的方法还是使用Quartz2D裁剪图片的方法。
 */
-(void)test1
{
    self.imageView.layer.cornerRadius = 100;
    self.imageView.layer.masksToBounds = YES;
    
    self.imageView.layer.borderColor = [UIColor yellowColor].CGColor;
    self.imageView.layer.borderWidth = 10;
    
    //可以通过图层(layer)的contents属性得知UIImageView控件是否具有内容层。
    NSLog(@"%@", self.imageView.layer.contents);
}

/**
 给一个类中的属性赋值一般有如下的两种方式：
 1、用点语法的方式给属性赋值；
 2、用KVC的方式给属性赋值：KVC实际上是一种给属性赋值的方法。一个类中如果有基本类（NSString，NSDictionary，NSArray等）的对象作为本类的属性的话可以直接使用"setValue:属性值 forKey:属性名"的方式（也称简单路径方式）给这个属性赋值。如果一个类中有除基本类之外的第三方类的对象作为这个类的属性的话则应该使用"setValue:属性值 forKeyPath:属性名"的方式（也称为复合路径方式）给这个属性赋值。以上两种方式中的“属性名”必须和这个类中的属性名一样才可以。
 
 CALayer的transform属性是CATransform3D类的一个对象，可以通过设置transform属性来对UIView或UIImageView控件进行3D操作。
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:1.0 animations:^{
        /**
         用点语法的方式给属性赋值并实现图片翻转：
         CATransform3DMakeRotation里面的1，1，0代表以x，y平面上的一个向量为轴进行翻转。
         */
        self.imageView.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 0);
        
        /**
         用KVC的方式给属性赋值并实现图片翻转：
         */
//        NSValue *value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 1, 1, 0)];
//        [self.imageView.layer setValue:value forKeyPath:@"transform"];
        
        /**
         用KVC的方式给属性赋值并实现图片在二维平面上的旋转：
         */
//        [self.imageView.layer setValue:@(M_PI_4) forKeyPath:@"transform.rotation"];
        
        /**
         用KVC的方式给属性赋值并实现图片在x轴上的缩放：
         */
//        [self.imageView.layer setValue:@(0.5) forKeyPath:@"transform.scale.x"];
        
        /**
         用KVC的方式给属性赋值并实现图片在二维平面上的平移：
         */
//        [self.imageView.layer setValue:[NSValue valueWithCGPoint:CGPointMake(-100, -100)] forKeyPath:@"transform.translation"];
    }];
}

@end
