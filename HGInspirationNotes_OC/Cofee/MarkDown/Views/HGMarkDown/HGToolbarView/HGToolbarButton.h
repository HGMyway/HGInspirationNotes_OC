//
//  HGToolbarButton.h
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/30.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  The block used for each button.
 */
typedef void (^eventHandlerBlock)(void);


@interface HGToolbarButton : UIButton

+ (instancetype)buttonWithTitle:(NSString *)title;

+ (instancetype)buttonWithTitle:(NSString *)title andEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent;

- (void)addEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent;
@end
