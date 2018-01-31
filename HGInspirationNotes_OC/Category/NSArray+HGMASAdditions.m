	//
	//  NSArray+HGMASAdditions.m
	//  HGInspirationNotes_OC
	//
	//  Created by 小雨很美 on 2018/1/30.
	//  Copyright © 2018年 小雨很美. All rights reserved.
	//

#import "NSArray+HGMASAdditions.h"

@implementation NSArray (HGMASAdditions)
- (void)hg_mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing equalItemLength:(BOOL)equalItemLength minLenth:(CGFloat)minLenth{



	MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
	if (axisType == MASAxisTypeHorizontal) {

		__block MAS_VIEW *prev;
		[self enumerateObjectsUsingBlock:^(MAS_VIEW * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			[obj mas_makeConstraints:^(MASConstraintMaker *make) {
				if (idx == 0) {
					make.leading.mas_equalTo(tempSuperView).offset(leadSpacing);
				}else{
					make.leading.mas_equalTo(prev.mas_trailing).offset(fixedSpacing);
					if (equalItemLength) {
						make.width.mas_equalTo(prev);
					}

				}
				if (idx == self.count - 1) {
					make.trailing.mas_equalTo(tempSuperView).offset(-tailSpacing);
				}
				make.width.mas_greaterThanOrEqualTo(minLenth);
				prev = obj;
			}];
		}];
	} else {
		__block MAS_VIEW *prev;
		[self enumerateObjectsUsingBlock:^(MAS_VIEW * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			[obj mas_makeConstraints:^(MASConstraintMaker *make) {
				if (idx == 0) {
					make.top.mas_equalTo(tempSuperView).offset(leadSpacing);
				}else{
					make.top.mas_equalTo(prev.mas_bottom).offset(fixedSpacing);
					if (equalItemLength) {
						make.height.mas_equalTo(prev);
					}
				}
				if (idx == self.count - 1) {
					make.bottom.mas_equalTo(tempSuperView).offset(-tailSpacing);
				}
				make.height.mas_greaterThanOrEqualTo(minLenth);
				prev = obj;
			}];
		}];
	}
}

- (MAS_VIEW *)mas_commonSuperviewOfViews
{
	MAS_VIEW *commonSuperview = nil;
	MAS_VIEW *previousView = nil;
	for (id object in self) {
		if ([object isKindOfClass:[MAS_VIEW class]]) {
			MAS_VIEW *view = (MAS_VIEW *)object;
			if (previousView) {
				commonSuperview = [view mas_closestCommonSuperview:commonSuperview];
			} else {
				commonSuperview = view;
			}
			previousView = view;
		}
	}
	NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
	return commonSuperview;
}
@end

