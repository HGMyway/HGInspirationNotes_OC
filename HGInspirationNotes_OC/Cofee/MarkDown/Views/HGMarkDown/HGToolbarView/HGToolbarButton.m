//
//  HGToolbarButton.m
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/30.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGToolbarButton.h"
@interface HGToolbarButton()
@property (nonatomic, copy) eventHandlerBlock buttonPressBlock;
@end
@implementation HGToolbarButton


+ (instancetype)buttonWithTitle:(NSString *)title{
	HGToolbarButton *button = [HGToolbarButton buttonWithType:UIButtonTypeSystem];
	[button setTitle:title forState:UIControlStateNormal];
	return button;
}
+ (instancetype)buttonWithTitle:(NSString *)title andEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent{
	HGToolbarButton *button = [self buttonWithTitle:title];
	[button addEventHandler:eventHandler forControlEvents:controlEvent];
	return button;
}

- (instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	self.tintColor = [UIColor colorNamed:@"Color/globalTint"];
	self.backgroundColor = [UIColor colorNamed:@"Color/separatorColor"];
	self.layer.cornerRadius = 4;
	self.contentEdgeInsets = UIEdgeInsetsMake(2, 4, 2, 4);

	return self;
}


- (void)addEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent {
	self.buttonPressBlock = eventHandler;
	[self addTarget:self action:@selector(buttonPressed) forControlEvents:controlEvent];
}
- (void)buttonPressed {
	self.buttonPressBlock();
}

@end
