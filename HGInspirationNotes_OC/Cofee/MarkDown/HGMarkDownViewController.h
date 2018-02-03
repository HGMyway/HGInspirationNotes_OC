//
//  HGMarkDownViewController.h
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/30.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGBaseViewController.h"
#import "HGCollectionDBModel.h"
@interface HGMarkDownViewController : HGBaseViewController
@property (nonatomic, strong)HGCollectionDBModel *currentModel;
@property (nonatomic) NSInteger currentIndex;
@end
