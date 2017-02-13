//
//  ImageWithLabels.h
//  ViewLabelTest
//
//  Created by 曹雪莹 on 2016/11/9.
//  Copyright © 2016年 曹雪莹. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 PageControl 对齐方式
 
 - XYLabelsLocationTop: Label在顶部
 - XYLabelsLocationLeft: Label在左侧
 - XYLabelsLocationRight: Label在右侧
 - XYLabelsLocationBottom: Label在底部
 */
typedef NS_ENUM(NSInteger, XYLabelsLocation) {
	XYLabelsLocationTop,
	XYLabelsLocationLeft,
	XYLabelsLocationRight,
	XYLabelsLocationBottom
};

@interface ImageWithLabels : UIView

/**
 新建指定图片和文字的 ImageWithLabels

 @param frame 指定位置尺寸
 @param image 图片
 @param text1 第一个 Label 内容
 @param text2 第二个 Label 内容

 @return ImageWithLabels
 */
+ (instancetype)imageLabelsWithFrame:(CGRect)frame Image:(UIImage *)image Text1:(NSString *)text1 Text2:(NSString *)text2;

/**
 新建指定占位图片和文字的 ImageWithLabels

 @param frame       指定位置尺寸
 @param placeHolder 占位图片
 @param text1       第一个 Label 内容
 @param text2       第二个 Label 内容

 @return ImageWithLabels
 */
+ (instancetype)imageLabelsWithFrame:(CGRect)frame placeHolder:(UIImage *)placeHolder Text1:(NSString *)text1 Text2:(NSString *)text2;

/**
 通过 url 设置 image
 */
@property (nonatomic, copy) NSString *image;

/**
 Label 文字
 */
@property (nonatomic, copy) NSString *text1;
@property (nonatomic, copy) NSString *text2;

/**
 圆角半径
 */
@property (nonatomic, assign) CGFloat radius;

/**
 字体
 默认系统12号字体
 */
@property (nonatomic, strong) UIFont *label1Font;
@property (nonatomic, strong) UIFont *label2Font;

/**
 字体颜色
 */
@property (nonatomic, strong) UIColor *label1Color;
@property (nonatomic, strong) UIColor *label2Color;

/**
 文字背景颜色
 */
@property (nonatomic, strong) UIColor *label1BackgroundColor;
@property (nonatomic, strong) UIColor *label2BackgroundColor;

/**
 Label 行数
 */
@property (nonatomic, assign) NSInteger label1NumberOfLines;
@property (nonatomic, assign) NSInteger label2NumberOfLines;

/**
 Label 文字对齐方式
 默认居中对齐
 */
@property (nonatomic, assign) NSTextAlignment textAlign1;
@property (nonatomic, assign) NSTextAlignment textAlign2;

/**
 Label 背景颜色
 */
@property (nonatomic, strong) UIColor *label1BacgroudColor;
@property (nonatomic, strong) UIColor *label2BacgroudColor;

/**
 Label 中划线
 */
@property (nonatomic, assign) BOOL label1AddLine;
@property (nonatomic, assign) BOOL label2AddLine;

/**
 Label 位置
 默认在下方
 */
@property (nonatomic, assign) XYLabelsLocation labelsLocation;

/**
 Label 左右留白的距离
 默认为 0
 */
@property (nonatomic, assign) NSInteger label1OffsetX;
@property (nonatomic, assign) NSInteger label2OffsetX;

/**
 Label 上下留白的距离
 默认为 0
 */
@property (nonatomic, assign) NSInteger label1OffsetY;
@property (nonatomic, assign) NSInteger label2OffsetY;

/**
 图片的 contentMode
 默认为 UIViewContentModeScaleAspectFit
 */
@property (nonatomic, assign) UIViewContentMode contentMode;


/**
 图片的 宽:高
 */
@property (nonatomic, assign) CGFloat imageRatio;

/**
 图片头部偏移量
 */
@property (nonatomic, assign) CGFloat imageTopOffset;

@end
