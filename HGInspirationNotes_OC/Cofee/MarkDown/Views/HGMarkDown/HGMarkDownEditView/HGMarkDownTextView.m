//
//  HGMarkDownTextView.m
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/30.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGMarkDownTextView.h"
#import "HGButtonsBarView.h"
#import "HGToolbarButton.h"

#import <MMMarkdown/MMMarkdown.h>
#import <RegexKitLite-NoWarning/RegexKitLite.h>
@implementation HGMarkDownTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
	[super awakeFromNib];
	[self configTextView];
}
- (instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	[self configTextView];
	return self;
}
- (void)configTextView{
	self.inputAccessoryView = [HGButtonsBarView toolbarWithButtons:[self buttons]];
}
- (NSArray <HGToolbarButton *>*)buttons {
	return @[

//			 [self createButtonWithTitle:@"@" andEventHandler:^{ [self doAT]; }],

			 [self createButtonWithTitle:@"#" andEventHandler:^{ [self insertText:@"#"]; }],
			 [self createButtonWithTitle:@"*" andEventHandler:^{ [self insertText:@"*"]; }],
			 [self createButtonWithTitle:@"`" andEventHandler:^{ [self insertText:@"`"]; }],
			 [self createButtonWithTitle:@"-" andEventHandler:^{ [self insertText:@"-"]; }],

//			 [self createButtonWithTitle:@"照片" andEventHandler:^{ [self doPhoto]; }],

			 [self createButtonWithTitle:@"标题" andEventHandler:^{ [self doTitle]; }],
			 [self createButtonWithTitle:@"粗体" andEventHandler:^{ [self doBold]; }],
			 [self createButtonWithTitle:@"斜体" andEventHandler:^{ [self doItalic]; }],
			 [self createButtonWithTitle:@"代码" andEventHandler:^{ [self doCode]; }],
			 [self createButtonWithTitle:@"引用" andEventHandler:^{ [self doQuote]; }],
			 [self createButtonWithTitle:@"列表" andEventHandler:^{ [self doList]; }],

			 [self createButtonWithTitle:@"链接" andEventHandler:^{
				 NSString *tipStr = @"在此输入链接地址";
				 NSRange selectionRange = self.selectedRange;
				 selectionRange.location += 5;
				 selectionRange.length = tipStr.length;

				 [self insertText:[NSString stringWithFormat:@"[链接](%@)", tipStr]];
				 [self setSelectionRange:selectionRange];
			 }],

			 [self createButtonWithTitle:@"图片链接" andEventHandler:^{
				 NSString *tipStr = @"在此输入图片地址";
				 NSRange selectionRange = self.selectedRange;
				 selectionRange.location += 6;
				 selectionRange.length = tipStr.length;

				 [self insertText:[NSString stringWithFormat:@"![图片](%@)", tipStr]];
				 [self setSelectionRange:selectionRange];
			 }],

			 [self createButtonWithTitle:@"分割线" andEventHandler:^{
				 NSRange selectionRange = self.selectedRange;
				 NSString *insertStr = [self needPreNewLine]? @"\n\n------\n": @"\n------\n";

				 selectionRange.location += insertStr.length;
				 selectionRange.length = 0;

				 [self insertText:insertStr];
				 [self setSelectionRange:selectionRange];
			 }],

			 [self createButtonWithTitle:@"_" andEventHandler:^{ [self insertText:@"_"]; }],
			 [self createButtonWithTitle:@"+" andEventHandler:^{ [self insertText:@"+"]; }],
			 [self createButtonWithTitle:@"~" andEventHandler:^{ [self insertText:@"~"]; }],
			 [self createButtonWithTitle:@"=" andEventHandler:^{ [self insertText:@"="]; }],
			 [self createButtonWithTitle:@"[" andEventHandler:^{ [self insertText:@"["]; }],
			 [self createButtonWithTitle:@"]" andEventHandler:^{ [self insertText:@"]"]; }],
			 [self createButtonWithTitle:@"<" andEventHandler:^{ [self insertText:@"<"]; }],
			 [self createButtonWithTitle:@">" andEventHandler:^{ [self insertText:@">"]; }]
			 ];
}

- (BOOL)needPreNewLine{
	NSString *preStr = [self.text substringToIndex:self.selectedRange.location];
	return !(preStr.length == 0
			 || [preStr isMatchedByRegex:@"[\\n\\r]+[\\t\\f]*$"]);
}


- (HGToolbarButton *)createButtonWithTitle:(NSString*)title andEventHandler:(void(^)(void))handler {
	return [HGToolbarButton buttonWithTitle:title andEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelectionRange:(NSRange)range {
	UIColor *previousTint = self.tintColor;

	self.tintColor = UIColor.clearColor;
	self.selectedRange = range;
	self.tintColor = previousTint;
}

#pragma mark md_Method
- (void)doTitle{
	[self doMDWithLeftStr:@"## " rightStr:@" ##" tipStr:@"在此输入标题" doNeedPreNewLine:YES];
}

- (void)doBold{
	[self doMDWithLeftStr:@"**" rightStr:@"**" tipStr:@"在此输入粗体文字" doNeedPreNewLine:NO];
}

- (void)doItalic{
	[self doMDWithLeftStr:@"*" rightStr:@"*" tipStr:@"在此输入斜体文字" doNeedPreNewLine:NO];
}

- (void)doCode{
	[self doMDWithLeftStr:@"```\n" rightStr:@"\n```" tipStr:@"在此输入代码片段" doNeedPreNewLine:YES];
}

- (void)doQuote{
	[self doMDWithLeftStr:@"> " rightStr:@"" tipStr:@"在此输入引用文字" doNeedPreNewLine:YES];
}

- (void)doList{
	[self doMDWithLeftStr:@"- " rightStr:@"" tipStr:@"在此输入列表项" doNeedPreNewLine:YES];
}

- (void)doMDWithLeftStr:(NSString *)leftStr rightStr:(NSString *)rightStr tipStr:(NSString *)tipStr doNeedPreNewLine:(BOOL)doNeedPreNewLine{

	BOOL needPreNewLine = doNeedPreNewLine? [self needPreNewLine]: NO;


	if (!leftStr || !rightStr || !tipStr) {
		return;
	}
	NSRange selectionRange = self.selectedRange;
	NSString *insertStr = [self.text substringWithRange:selectionRange];

	if (selectionRange.length > 0) {//已有选中文字
									//撤销
		if (selectionRange.location >= leftStr.length && selectionRange.location + selectionRange.length + rightStr.length <= self.text.length) {
			NSRange expandRange = NSMakeRange(selectionRange.location- leftStr.length, selectionRange.length +leftStr.length +rightStr.length);

			expandRange = [self.text rangeOfString:[NSString stringWithFormat:@"%@%@%@", leftStr, insertStr, rightStr] options:NSLiteralSearch range:expandRange];

			if (expandRange.location != NSNotFound) {
				selectionRange.location -= leftStr.length;
				selectionRange.length = insertStr.length;
				[self setSelectionRange:expandRange];
				[self insertText:insertStr];
				[self setSelectionRange:selectionRange];
				return;
			}
		}
			//添加
		selectionRange.location += needPreNewLine? leftStr.length +1: leftStr.length;
		insertStr = [NSString stringWithFormat:needPreNewLine? @"\n%@%@%@": @"%@%@%@", leftStr, insertStr, rightStr];
	}else{//未选中任何文字
		  //添加
		selectionRange.location += needPreNewLine? leftStr.length +1: leftStr.length;
		selectionRange.length = tipStr.length;
		insertStr = [NSString stringWithFormat:needPreNewLine? @"\n%@%@%@": @"%@%@%@", leftStr, tipStr, rightStr];
	}
	[self insertText:insertStr];
	[self setSelectionRange:selectionRange];
}



#pragma mark -
- (NSString *)HTMLStringOfMarkdown{
	return [MMMarkdown HTMLStringWithMarkdown:self.text error:nil];
}
- (NSString *)HTMLStringOfMarkdownAndExtensions:(MMMarkdownExtensions)extensions{
	return [MMMarkdown HTMLStringWithMarkdown:self.text extensions:extensions error:nil];
}

- (NSString *)HTMLStringOfMarkDownForShow{
	
	NSError *error = nil;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"markdown" ofType:@"html"];
	NSString *markdown_pattern_htmlStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];

	if (error) {
		NSLog(@"markdown_pattern_htmlStr fail: %@", error.description);
		return  nil;
	}else{
		NSString *htmlString = [markdown_pattern_htmlStr stringByReplacingOccurrencesOfString:@"${webview_content}" withString:[self HTMLStringOfMarkdown]];
		return htmlString;
	}
}


//- (NSString *)HTMLEscapeStringOfMarkdown{
//	return [self.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
//}

@end
