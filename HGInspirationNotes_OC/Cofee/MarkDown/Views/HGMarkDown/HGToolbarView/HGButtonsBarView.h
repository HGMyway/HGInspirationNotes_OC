//
//  HGButtonsBarView.h
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/30.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGButtonsBarView : UIView
@property (nonatomic, strong) NSArray <UIButton *>*buttons;

+ (instancetype)toolbarWithButtons:(NSArray <UIButton *>*)buttons;
@end
