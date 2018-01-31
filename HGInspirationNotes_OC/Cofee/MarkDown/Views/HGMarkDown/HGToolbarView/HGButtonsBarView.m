//
//  HGButtonsBarView.m
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/30.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGButtonsBarView.h"

#import "NSArray+HGMASAdditions.h"

@interface HGButtonsBarView ()
@property (nonatomic, strong) UIView *toolbarView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end
@implementation HGButtonsBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (CGSize)intrinsicContentSize{
	return CGSizeMake(UIViewNoIntrinsicMetric, 40);
}
- (UILayoutPriority)contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxis)axis{
	switch (axis) {
		case UILayoutConstraintAxisHorizontal:
			return UILayoutPriorityRequired;
		default:
			return [super contentCompressionResistancePriorityForAxis:axis];
	}
}
- (UILayoutPriority)contentHuggingPriorityForAxis:(UILayoutConstraintAxis)axis{
	switch (axis) {
		case UILayoutConstraintAxisHorizontal:
			return UILayoutPriorityRequired;
		default:
			return [super contentHuggingPriorityForAxis:axis];
	}
}



+ (instancetype)toolbarWithButtons:(NSArray <UIButton *>*)buttons{
	return [[HGButtonsBarView alloc] initWithButtons:buttons];;
}

- (UIView *)toolbarView{
	if (_toolbarView == nil) {
		_toolbarView = [UIView new];
		_toolbarView.backgroundColor = [UIColor colorNamed:@"Color/contentBackgroundColor"];
		[self addSubview:_toolbarView];
		[_toolbarView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(self);
		}];
	}
	return _toolbarView;
}
- (UIScrollView *)scrollView{
	if (_scrollView == nil) {
		_scrollView = [UIScrollView new];
		_scrollView.showsHorizontalScrollIndicator = NO;
		[self.toolbarView addSubview:_scrollView];
		[_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(self.toolbarView);
		}];
	}
	return _scrollView;

}
- (instancetype)initWithButtons:(NSArray <UIButton *>*)buttons{
	self = [self init];
	self.buttons = buttons;
	return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	return self;
}
- (void)setButtons:(NSArray<UIButton *> *)buttons{
	[_buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
	_buttons = [buttons copy];
	[self addButtons];
}
- (void)addButtons{

	[self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[self.scrollView addSubview:obj];
	}];

	[self.buttons mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(self);
	}];
	[self.buttons hg_mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:4 leadSpacing:6 tailSpacing:6 equalItemLength:NO minLenth:40];

}

@end
