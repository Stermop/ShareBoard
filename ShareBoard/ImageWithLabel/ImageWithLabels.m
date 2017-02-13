//
//  ImageWithLabels.m
//  ViewLabelTest
//
//  Created by 曹雪莹 on 2016/11/9.
//  Copyright © 2016年 曹雪莹. All rights reserved.
//

#import "ImageWithLabels.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface ImageWithLabels ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *label1;
@property (nonatomic, weak) UILabel *label2;
@property (nonatomic, strong) UIImage *placeHolder;

@end

@implementation ImageWithLabels

/**
 新建指定图片和文字的 ImageWithLabels
 */
+ (instancetype)imageLabelsWithFrame:(CGRect)frame Image:(UIImage *)image Text1:(NSString *)text1 Text2:(NSString *)text2 {
	
	ImageWithLabels *view = [[self alloc] initWithFrame:frame Image:image Text1:text1 Text2:text2];
	view.placeHolder = image;
	return view;
}

/**
 新建指定占位图片和文字的 ImageWithLabels
 */
+ (instancetype)imageLabelsWithFrame:(CGRect)frame placeHolder:(UIImage *)placeHolder Text1:(NSString *)text1 Text2:(NSString *)text2 {
	
	ImageWithLabels *view = [[self alloc] initWithFrame:frame Image:placeHolder Text1:text1 Text2:text2];
	view.placeHolder = placeHolder;
	return view;
}

- (ImageWithLabels *)initWithFrame:(CGRect)frame Image:(UIImage *)image Text1:(NSString *)text1 Text2:(NSString *)text2 {
	
	self = [super initWithFrame:frame];
	
	if (self) {
		// 默认属性
		_label1Font = [UIFont systemFontOfSize:12];
		_label2Font = [UIFont systemFontOfSize:12];
		_labelsLocation = XYLabelsLocationBottom;
		
		// Label1
		UILabel *label1 = [[UILabel alloc] init];
		label1.text = text1;
		label1.font = [UIFont systemFontOfSize:12];
		label1.userInteractionEnabled = NO;
		label1.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label1];
		self.label1 = label1;
		
		// Label2
		UILabel *label2 = [[UILabel alloc] init];
		label2.text = text2;
		label2.font = [UIFont systemFontOfSize:12];
		label2.userInteractionEnabled = NO;
		label2.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label2];
		self.label2 = label2;
		
		// ImageView
		UIImageView *imageView = [[UIImageView alloc] init];
		imageView.userInteractionEnabled = NO;
		imageView.image = image;
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:imageView];
		self.imageView = imageView;
	}
	return self;
}

- (void)layoutSubviews {
	
	[super layoutSubviews];
	
	CGSize size1, size2;
	// 保证 offsex 不越界
	CGFloat offsetX1 = (self.label1OffsetX < self.frame.size.width ? self.label1OffsetX: self.frame.size.width) / 2;
	CGFloat offsetX2 = (self.label2OffsetX < self.frame.size.width ? self.label2OffsetX: self.frame.size.width) / 2;
	
	if (_label1NumberOfLines == 1) {
		
		size1 = [self.label1.text sizeWithAttributes:@{NSFontAttributeName:self.label1Font}];
	} else {
		
		size1 = [self.label1.text boundingRectWithSize:CGSizeMake(self.frame.size.width - (offsetX1 * 2), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.label1Font} context:nil].size;
		
		if(_label1NumberOfLines > 0) {

			size1.height = self.label1.font.lineHeight * self.label1NumberOfLines;
		}
	}
	
	if (_label2NumberOfLines == 1) {
		
		size2 = [self.label2.text sizeWithAttributes:@{NSFontAttributeName:self.label2Font}];
	} else {
		
		size2 = [self.label2.text boundingRectWithSize:CGSizeMake(self.frame.size.width - (offsetX2 * 2), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.label2Font} context:nil].size;
		
		if(_label2NumberOfLines > 0) {
			
			size2.height = self.label2.font.lineHeight * self.label2NumberOfLines;
		}
	}
	
	CGFloat height1 = ceil(size1.height) + self.label1OffsetY;
	CGFloat height2 = ceil(size2.height) + self.label2OffsetY;
	
	// 放置子视图
	switch (self.labelsLocation) {

		case XYLabelsLocationTop: {
			[self.label1 mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.top.equalTo(self.mas_top);
				make.left.equalTo(self.mas_left).offset(offsetX1);
				make.right.equalTo(self.mas_right).offset(- offsetX1);
				make.height.equalTo(@(height1));
			}];
			[self.label2 mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.top.equalTo(self.label1.mas_bottom);
				make.left.equalTo(self.mas_left).offset(offsetX2);
				make.right.equalTo(self.mas_right).offset(- offsetX2);
				make.height.equalTo(@(height2));
			}];
			[self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.top.equalTo(self.label2.mas_bottom);
				make.centerX.equalTo(self.mas_centerX);
				make.size.mas_equalTo(self.imageView.image.size);
			}];
		}
			break;
		case XYLabelsLocationLeft: {
			[self.label1 mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_left).offset(offsetX1);
				make.right.equalTo(self.mas_centerX).offset(- offsetX1);
				make.height.equalTo(@(height1));
				make.bottom.equalTo(self.mas_centerY);
			}];
			[self.label2 mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_left).offset(offsetX2);
				make.right.equalTo(self.mas_centerX).offset(- offsetX2);
				make.height.equalTo(@(height2));
				make.top.equalTo(self.mas_centerY);
			}];
			[self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_centerX);
				make.centerY.equalTo(self.mas_centerY);
				make.size.mas_equalTo(self.imageView.image.size);
			}];
		}
			break;
		case XYLabelsLocationRight: {
			[self.label1 mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_centerX).offset(offsetX1);
				make.right.equalTo(self.mas_right).offset(- offsetX1);
				make.height.equalTo(@(height1));
				make.bottom.equalTo(self.mas_centerY);
			}];
			[self.label2 mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.top.equalTo(self.mas_centerY);
				make.height.equalTo(@(height2));
				make.left.equalTo(self.mas_centerX).offset(offsetX2);
				make.right.equalTo(self.mas_right).offset(- offsetX2);
			}];
			[self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.right.equalTo(self.mas_centerX);
				make.centerY.equalTo(self.mas_centerY);
				make.size.mas_equalTo(self.imageView.image.size);
			}];
		}
			break;
		case XYLabelsLocationBottom: {
			[self.label2 mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_left).offset(offsetX2);
				make.right.equalTo(self.mas_right).offset(- offsetX2);
				make.bottom.equalTo(self.mas_bottom);
				make.height.equalTo(@(height2));
			}];
			[self.label1 mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_left).offset(offsetX1);
				make.right.equalTo(self.mas_right).offset(- offsetX1);
				make.bottom.equalTo(self.label2.mas_top);
				make.height.equalTo(@(height1));
			}];
			[self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_left);
				make.right.equalTo(self.mas_right);
				make.top.equalTo(self.mas_top).offset(self.imageTopOffset);
				
				if (self.imageRatio) {
					make.height.equalTo(self.imageView.mas_width)
						.multipliedBy(1.0/self.imageRatio);
				} else {
					make.bottom.equalTo(self.label1.mas_top);
				}
			}];
		}
			break;
	}
}

#pragma mark -- 设置可变属性

/**
 通过 url 设置 imageView 的 image
 
 @param image 获取image的url
 */
- (void)setImage:(NSString *)image {
	
	_image = image;
	[self.imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:self.placeHolder];
}

/**
 设置 label 的文字

 @param text1 文字
 */
- (void)setText1:(NSString *)text1 {
	
	_text1 = text1;
	self.label1.text = text1;
}

- (void)setText2:(NSString *)text2 {
	
	_text2 = text2;
	self.label2.text = text2;
}

/**
 设置view的圆角半径
 
 @param radius 圆角半径
 */
- (void)setRadius:(CGFloat)radius {
	
	_radius = radius;
	self.layer.masksToBounds = YES;
	self.layer.cornerRadius = radius;
}

/**
 设置 label 的字体
 
 @param label1Font 字体
 */
- (void)setLabel1Font:(UIFont *)label1Font {
	
	_label1Font = label1Font;
	self.label1.font = label1Font;
}

- (void)setLabel2Font:(UIFont *)label2Font {
	
	_label2Font = label2Font;
	self.label2.font = label2Font;
}

/**
 设置 label 的字体颜色
 
 @param label1Color 字体颜色
 */
- (void)setLabel1Color:(UIColor *)label1Color {
	
	_label1Color = label1Color;
	self.label1.textColor = label1Color;
}

- (void)setLabel2Color:(UIColor *)label2Color {
	
	_label2Color = label2Color;
	self.label2.textColor = label2Color;
}

/**
 设置 label 的背景颜色
 */
- (void)setLabel1BackgroundColor:(UIColor *)label1BackgroundColor {
	
	_label1BackgroundColor = label1BackgroundColor;
	self.label1.backgroundColor = label1BackgroundColor;
	self.label1.layer.masksToBounds = true;
}

- (void)setLabel2BackgroundColor:(UIColor *)label2BackgroundColor {
	
	_label2BackgroundColor = label2BackgroundColor;
	self.label2.backgroundColor = label2BackgroundColor;
}

/**
 设置 label 的背景颜色
 
 @param label1BacgroudColor 背景颜色
 */
- (void)setLabel1BacgroudColor:(UIColor *)label1BacgroudColor {
	
	_label1BacgroudColor = label1BacgroudColor;
	self.label1.backgroundColor = label1BacgroudColor;
}

- (void)setLabel2BacgroudColor:(UIColor *)label2BacgroudColor {
	
	_label2BacgroudColor = label2BacgroudColor;
	self.label2.backgroundColor = label2BacgroudColor;
}

/**
 设置 label 的对齐方式
 
 @param textAlign1 对齐方式
 */
- (void)setTextAlign1:(NSTextAlignment)textAlign1 {
	
	_textAlign1 = textAlign1;
	self.label1.textAlignment = textAlign1;
}

- (void)setTextAlign2:(NSTextAlignment)textAlign2 {
	
	_textAlign2 = textAlign2;
	self.label2.textAlignment = textAlign2;
}

/**
 设置 label 行数
 
 @param label1NumberOfLines 行数
 */
- (void)setLabel1NumberOfLines:(NSInteger)label1NumberOfLines {
	
	_label1NumberOfLines = label1NumberOfLines;
	self.label1.numberOfLines = label1NumberOfLines;
}

- (void)setLabel2NumberOfLines:(NSInteger)label2NumberOfLines {
	
	_label2NumberOfLines = label2NumberOfLines;
	self.label2.numberOfLines = label2NumberOfLines;
}

/**
 设置 label 的中划线

 @param label1AddLine 是否添加中划线，默认为不添加
 */
- (void)setLabel1AddLine:(BOOL)label1AddLine {
	
	_label1AddLine = label1AddLine;
	if (label1AddLine == YES) {
		
		//中划线
		NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
		NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.label1.text attributes:attribtDic];
		
		// 赋值
		self.label1.attributedText = attribtStr;
	} else {
		
		return;
	}
}

- (void)setLabel2AddLine:(BOOL)label2AddLine {
	
	_label2AddLine = label2AddLine;
	if (label2AddLine == YES) {
		
		//中划线
		NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
		NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.label2.text attributes:attribtDic];
		
		// 赋值
		self.label2.attributedText = attribtStr;
	} else {
		
		return;
	}
}

/**
 设置 label 位置
 
 @param labelsLocation 位置
 */
- (void)setLabelsLocation:(XYLabelsLocation)labelsLocation {
	
	if (_labelsLocation == labelsLocation) {
		
		return;
	} else {
		
		_labelsLocation = labelsLocation;
		[self layoutSubviews];
	}
}

/**
 设置 label 左右留白的距离
 
 @param label1OffsetX 左右留白的距离
 */
- (void)setLabel1OffsetX:(NSInteger)label1OffsetX {
	
	if (_label1OffsetX == label1OffsetX) {
		
		return;
	} else {
		
		_label1OffsetX = label1OffsetX;
		[self setNeedsLayout];
	}
}

- (void)setLabel2OffsetX:(NSInteger)label2OffsetX {
	
	if (_label2OffsetX == label2OffsetX) {
		
		return;
	} else {
		
		_label2OffsetX = label2OffsetX;
		[self setNeedsLayout];
	}
}

/**
 设置 label 上下留白的距离
 
 @param label1OffsetY 上下留白的距离
 */
- (void)setLabel1OffsetY:(NSInteger)label1OffsetY {
	
	if (_label1OffsetY == label1OffsetY) {
		
		return;
	} else {
		
		_label1OffsetY = label1OffsetY;
		[self setNeedsLayout];
	}
}

- (void)setlabel2OffsetY:(NSInteger)label2OffsetY {
	
	if (_label2OffsetY == label2OffsetY) {
		
		return;
	} else {
		
		_label2OffsetY = label2OffsetY;
		[self setNeedsLayout];
	}
}

/**
 设置 imageView 的 contentMode
 
 @param contentMode contentMode
 */
- (void)setContentMode:(UIViewContentMode)contentMode {
	
	if (_contentMode == contentMode) {
		return;
	} else {
		
		_contentMode = contentMode;
		self.imageView.contentMode = contentMode;
	}
}

@end
