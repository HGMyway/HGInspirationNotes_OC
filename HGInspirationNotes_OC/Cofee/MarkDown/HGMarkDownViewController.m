//
//  HGMarkDownViewController.m
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/30.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGMarkDownViewController.h"
#import "HGMarkDownTextView.h"
#import <ReactiveCocoa.h>
#import <WebKit/WebKit.h>
@interface HGMarkDownViewController ()<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet HGMarkDownTextView *markdownTextView;
@property (weak, nonatomic) IBOutlet WKWebView *wkwebview;

@end

@implementation HGMarkDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.wkwebview.navigationDelegate = self;
	[self.markdownTextView becomeFirstResponder];



	[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification *aNotification) {
		if (self.markdownTextView) {
			NSDictionary* userInfo = [aNotification userInfo];
			CGRect keyboardEndFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
			self.markdownTextView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(keyboardEndFrame), 0);
			self.markdownTextView.scrollIndicatorInsets = self.markdownTextView.contentInset;
		}
	}];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)switchMarkDownStateAction:(UISegmentedControl *)sender {
	if (sender.selectedSegmentIndex == 0) {
		[self switchToEditView];
	}else{
		[self switchToLookView];
	}
}

- (void)switchToEditView{
	self.markdownTextView.hidden = NO;
	self.wkwebview.hidden = YES;
	[self.markdownTextView becomeFirstResponder];
}
- (void)switchToLookView{
	self.markdownTextView.hidden = YES;
	self.wkwebview.hidden = NO;
	[self.markdownTextView resignFirstResponder];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[self.wkwebview loadHTMLString:self.markdownTextView.HTMLStringOfMarkDownForShow baseURL:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
