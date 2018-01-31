//
//  HGMarkDownTextView.h
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/30.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, MMMarkdownExtensions);

@interface HGMarkDownTextView : UITextView

- (NSString *)HTMLStringOfMarkDownForShow;
//- (NSString *)HTMLEscapeStringOfMarkdown;
- (NSString *)HTMLStringOfMarkdown;
- (NSString *)HTMLStringOfMarkdownAndExtensions:(MMMarkdownExtensions)extensions;
@end
