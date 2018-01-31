//
//  NSArray+HGMASAdditions.h
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/30.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry.h>
@interface NSArray (HGMASAdditions)
- (void)hg_mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing equalItemLength:(BOOL)equalItemLength minLenth:(CGFloat)minLenth;

@end
