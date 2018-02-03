//
//  HGCollectionTableViewCell.h
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/2/2.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGBaseTableViewCell.h"
#import "HGCollectionDBModel.h"
@interface HGCollectionTableViewCell : HGBaseTableViewCell
- (void)refreshCell:(HGCollectionDBModel *)model;
@end
