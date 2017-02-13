//
//  ImageWithLabel.m
//  ViewLabelTest
//
//  Created by 曹雪莹 on 16/11/7.
//  Copyright © 2016年 曹雪莹. All rights reserved.
//

#import "ImageWithLabel.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface ImageWithLabel ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, strong) UIImage *placeHolder;

@end

@implementation ImageWithLabel

/**
 新建指定图片和文字的 ImageWithLabel
 */
+ (instancetype)imageLabelWithFrame:(CGRect)frame Image:(UIImage *)image LabelText:(NSString *)text {
	
	ImageWithLabel *view = [[self alloc] initWithFrame:frame Image:image LabelTest:text];
	view.placeHolder = image;
	return view;
}

/**
 新建指定 placeHolder 和文字的 ImageWithLabel
 */
+(instancetype)imageLabelWithFrame:(CGRect)frame placeHolder:(UIImage *)placeHolder LabelText:(NSString *)text {
	
	ImageWithLabel *view = [[self alloc] initWithFrame:frame Image:placeHolder LabelTest:text ];
	view.placeHolder = placeHolder;
	return view;
}

- (ImageWithLabel *)initWithFrame:(CGRect)frame Image:(UIImage *)image LabelTest:(NSString *)text {
	
	self = [super initWithFrame:frame];
	
	if (self) {
		
		// 默认属性
		_labelFont = [UIFont systemFontOfSize:12];
		_labelLocation = XYLabelLocationBottom;
		_imageScale = 1;
		
		// Label
		UILabel *label = [[UILabel alloc] init];
		label.text = text;
		label.font = [UIFont systemFontOfSize:12];
		label.userInteractionEnabled = NO;
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		self.label = label;
		
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

#pragma mark -- layoutSubviews
- (void)layoutSubviews {
	
	[super layoutSubviews];
	
	CGSize size;
	// 保证 offsex 不越界
	CGFloat offsetX = ((CGFloat)self.labelOffsetX < self.frame.size.width ? : self.frame.size.width )/ 2;
	if (_numberOfLines == 1) {
		
		size = [self.label.text sizeWithAttributes:@{NSFontAttributeName:self.labelFont}];
	} else {
		
		size = [self.label.text boundingRectWithSize:CGSizeMake(self.frame.size.width - (offsetX * 2), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.labelFont} context:nil].size;
		
		if(_numberOfLines > 0) {
			
			size.height = self.label.font.lineHeight * self.numberOfLines;
		}
	}
	
	CGFloat height = ceil(size.height) + self.labelOffsetY;
	
	switch (self.labelLocation) {
			
		case XYLabelLocationTop: {
			[self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_left).offset(offsetX);
				make.right.equalTo(self.mas_right).offset(- offsetX);
				make.top.equalTo(self.mas_top);
				make.height.equalTo(@(height));
			}];
			[self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.top.equalTo(self.label.mas_bottom);
				make.centerX.equalTo(self.mas_centerX);
				make.size.mas_equalTo(self.imageView.image.size);
			}];

		}
			break;
		case XYLabelLocationLeft: {
			[self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_left).offset(offsetX);
				make.right.equalTo(self.mas_centerX).offset(- offsetX);
				make.height.equalTo(@(height));
				make.centerY.equalTo(self.mas_centerY);
			}];
			[self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_centerX);
				make.centerY.equalTo(self.mas_centerY);
				make.size.mas_equalTo(self.imageView.image.size);
			}];
		}
			break;
		case XYLabelLocationRight: {
			[self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_centerX).offset(offsetX);
				make.right.equalTo(self.mas_right).offset(- offsetX);
				make.centerY.equalTo(self.mas_centerY);
				make.height.equalTo(@(height));
			}];
			[self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.right.equalTo(self.mas_centerX);
				make.centerY.equalTo(self.mas_centerY);
				make.size.mas_equalTo(self.imageView.image.size);
			}];
		}
			break;
		case XYLabelLocationBottom: {
			[self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.left.equalTo(self.mas_left).offset(offsetX);
				make.right.equalTo(self.mas_right).offset(- offsetX);
				make.bottom.equalTo(self.mas_bottom);
				make.height.equalTo(@(height));
			}];			
			[self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				
				make.bottom.equalTo(self.label.mas_top);
				make.centerX.equalTo(self.mas_centerX);
				make.width.offset(self.imageView.image.size.width * self.imageScale);
				make.height.offset(self.imageView.image.size.height * self.imageScale);
//make.size.mas_equalTo(self.imageView.image.size).multipliedBy(self.imageScale);
				
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

 @param text 文字
 */
- (void)setText:(NSString *)text {
	
	_text = text;
	self.label.text = text;
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
 
 @param labelFont 字体
 */
- (void)setLabelFont:(UIFont *)labelFont {
	
	_labelFont = labelFont;
	self.label.font = labelFont;
}

/**
 设置 label 的字体颜色
 
 @param labelColor 字体颜色
 */
- (void)setLabelColor:(UIColor *)labelColor {
	
	_labelColor = labelColor;
	self.label.textColor = labelColor;
}

/**
 设置 label 的背景颜色
 
 @param labelBacgroudColor 背景颜色
 */
- (void)setLabelBacgroudColor:(UIColor *)labelBacgroudColor {
	
	_labelBacgroudColor = labelBacgroudColor;
	self.label.backgroundColor = labelBacgroudColor;
}

/**
 设置 label 的对齐方式
 
 @param textAlign 对齐方式
 */
- (void)setTextAlign:(NSTextAlignment)textAlign {
	
	_textAlign = textAlign;
	self.label.textAlignment = textAlign;
}

/**
 设置 label 行数
 
 @param numberOfLines 行数
 */
- (void)setNumberOfLines:(NSInteger)numberOfLines {
	
	_numberOfLines = numberOfLines;
	self.label.numberOfLines = numberOfLines;
}

/**
 设置 label 位置
 
 @param labelLocation 位置
 */
- (void)setLabelLocation:(XYLabelLocation)labelLocation {
	
	if (_labelLocation == labelLocation) {
		
		return;
	} else {
		
		_labelLocation = labelLocation;
		[self layoutSubviews];
	}
}

/**
 设置 label 左右留白的距离

 @param labelOffsetX 左右留白的距离
 */
- (void)setLabelOffsetX:(NSInteger)labelOffsetX {
	
	if (_labelOffsetX == labelOffsetX) {
		
		return;
	} else {
		
		_labelOffsetX = labelOffsetX;
		[self layoutSubviews];
	}
}

/**
 设置 label 上下留白的距离

 @param labelOffsetY 上下留白的距离
 */
- (void)setlabelOffsetY:(NSInteger)labelOffsetY {
	
	if (_labelOffsetY == labelOffsetY) {
		
		return;
	} else {
		
		_labelOffsetY = labelOffsetY;
		[self layoutSubviews];
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

- (void)setImageScale:(CGFloat)imageScale {
	
	if (_imageScale != imageScale) {
		
		_imageScale = imageScale;
		[self setNeedsLayout];
	}
}
@end
