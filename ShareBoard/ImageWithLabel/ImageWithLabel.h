//
//  ImageWithLabel.h
//  ViewLabelTest
//
//  Created by 曹雪莹 on 16/11/7.
//  Copyright © 2016年 曹雪莹. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 PageControl 对齐方式
 
 - XYLabelLocationTop: Label在顶部
 - XYLabelLocationLeft: Label在左侧
 - XYLabelLocationRight: Label在右侧
 - XYLabelLocationBottom: Label在底部
 */
typedef NS_ENUM(NSInteger, XYLabelLocation) {
	XYLabelLocationTop,
	XYLabelLocationLeft,
	XYLabelLocationRight,
	XYLabelLocationBottom
};

@interface ImageWithLabel : UIView

/**
 新建指定图片和文字的 ImageWithLabel

 @param frame 指定位置尺寸
 @param image 图片
 @param text  图片描述

 @return ImageWithLabel
 */
+ (instancetype)imageLabelWithFrame:(CGRect)frame Image:(UIImage *)image LabelText:(NSString *)text;

/**
 新建指定 placeHolder 和文字的 ImageWithLabel

 @param frame       指定位置尺寸
 @param placeHolder 占位图片
 @param text        图片描述

 @return ImageWithLabel
 */
+(instancetype)imageLabelWithFrame:(CGRect)frame placeHolder:(UIImage *)placeHolder LabelText:(NSString *)text;

/**
 通过 url 设置 image
 */
@property (nonatomic, copy) NSString *image;

/**
 Label 文字
 */
@property (nonatomic, copy) NSString *text;

/**
 圆角半径
 */
@property (nonatomic, assign) CGFloat radius;

/**
 字体 
 默认系统12号字体
 */
@property (nonatomic, strong) UIFont *labelFont;

/**
 字体颜色
 */
@property (nonatomic, strong) UIColor *labelColor;

/**
 Label 行数
 */
@property(nonatomic) NSInteger numberOfLines;

/**
 Label 文字对齐方式
 默认居中对齐
 */
@property (nonatomic, assign) NSTextAlignment textAlign;

/**
 Label 背景颜色
 */
@property (nonatomic, strong) UIColor *labelBacgroudColor;

/**
 Label 位置
 默认在下方
 */
@property (nonatomic, assign) XYLabelLocation labelLocation;

/**
 Label 左右留白的距离
 默认为 0
 */
@property (nonatomic, assign) NSInteger labelOffsetX;

/**
 Label 上下留白的距离
 默认为 0
 */
@property (nonatomic, assign) NSInteger labelOffsetY;

/**
 图片的 contentMode
 默认为 UIViewContentModeScaleAspectFit
 */
@property (nonatomic, assign) UIViewContentMode contentMode;


/**
 图片放大缩小倍率
 */
@property (nonatomic, assign) CGFloat imageScale;

@end
