//
//  HGShowWebViewController.m
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/2/2.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGShowWebViewController.h"
#import <WebKit/WebKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface HGShowWebViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webview;
@property (weak, nonatomic) IBOutlet UIProgressView *progressview;

@end

@implementation HGShowWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self addRAC];
	[self reloadURL];
}

- (void)addRAC{
//	https://www.jianshu.com/p/87ef6720a096
		// 2.KVO
		// 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
		// observer:可以传入nil

	@weakify(self)
	[[self.webview rac_valuesAndChangesForKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew observer:nil]
	 subscribeNext:^(RACTuple* x) {
		 @strongify(self)
		 self.progressview.progress = ((NSNumber *)x.first).floatValue;
	 }];
	[[self.webview rac_valuesAndChangesForKeyPath:@"loading" options:NSKeyValueObservingOptionNew observer:nil]
	 subscribeNext:^(RACTuple* x) {
		 @strongify(self)
		 self.progressview.hidden = !((NSNumber *)x.first).boolValue;
		 [UIApplication sharedApplication].networkActivityIndicatorVisible = !self.progressview.hidden;
	 }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)reloadURL{
	if (self.urlStr == nil) {
		return;
	}
	NSURL *url = [NSURL URLWithString:self.urlStr];
	NSURLRequest *requset = [NSURLRequest requestWithURL:url];
	[self.webview loadRequest:requset];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
