//
//  ViewController.m
//  ShareBoard
//
//  Created by 曹雪莹 on 2017/2/13.
//  Copyright © 2017年 曹雪莹. All rights reserved.
//

#import "ViewController.h"
#import "ShareView.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setTitle:@"分享" forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(shareBoardBySelfDefined) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	
	[button mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.centerX.centerY.equalTo(self.view);
		make.width.offset(80);
		make.height.offset(30);
	}];
}

- (void)shareBoardBySelfDefined {
	
	BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
	BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
	
	NSMutableArray *titlearr 	= [NSMutableArray arrayWithCapacity:5];
	NSMutableArray *imageArr 	= [NSMutableArray arrayWithCapacity:5];
	NSMutableArray *typeArr 	= [NSMutableArray arrayWithCapacity:5];
	
	if (hadInstalledWeixin) {
		[titlearr addObjectsFromArray:@[@"微信", @"微信朋友圈"]];
		[imageArr addObjectsFromArray:@[@"wechat",@"friend"]];
		[typeArr addObjectsFromArray:@[@(ShareTypeWechatSession), @(ShareTypeWechatTimeLine)]];
	}
	if (hadInstalledQQ) {
		[titlearr addObjectsFromArray:@[@"QQ", @"QQ空间"]];
		[imageArr addObjectsFromArray:@[@"qq",@"qqz"]];
		[typeArr addObjectsFromArray:@[@(ShareTypeQQ), @(ShareTypeQZone)]];
	}
	[titlearr addObjectsFromArray:@[@"微博"]];
	[imageArr addObjectsFromArray:@[@"weibo"]];
	[typeArr addObject:@(ShareTypeSina)];
	
	ShareView *shareView = [[ShareView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"分享到"];
	[shareView setBtnClick:^(NSInteger btnTag) {
		NSLog(@"\n点击第几个====%d\n当前选中的按钮title====%@",(int)btnTag,titlearr[btnTag]);
		[self shareToPlatform:[typeArr[btnTag] integerValue]];
	}];
	[[UIApplication sharedApplication].keyWindow addSubview:shareView];
}

- (void)shareToPlatform:(ShareType)type {
	
	switch (type) {
		case ShareTypeWechatSession:
			NSLog(@"分享至微信");
			break;
		case ShareTypeWechatTimeLine:
			NSLog(@"分享至朋友圈");
			break;
		case ShareTypeQQ:
			NSLog(@"分享至QQ");
			break;
		case ShareTypeQZone:
			NSLog(@"分享至QQ空间");
			break;
		case ShareTypeSina:
			NSLog(@"分享至微博");
			break;
		default:
			break;
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end
