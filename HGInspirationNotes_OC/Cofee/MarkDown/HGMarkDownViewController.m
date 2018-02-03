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

#import "HGCollectionDBModel.h"
@interface HGMarkDownViewController ()<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet HGMarkDownTextView *markdownTextView;
@property (weak, nonatomic) IBOutlet UITextField *titleTxtField;
@property (weak, nonatomic) IBOutlet WKWebView *wkwebview;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation HGMarkDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.wkwebview.navigationDelegate = self;
	self.markdownTextView.text = self.currentModel.content;
	self.titleTxtField.text = self.currentModel.title;
	[self switchMarkDownState];

//	self.segmentedControl.selectedSegmentIndex = self.currentIndex;

	[self addRAC];
}
- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];

	NSLog(@"dddhhhhhhhhhh -- %f",self.markdownTextView.contentSize.height);
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		NSLog(@"hhhhhhhhhh -- %f",self.markdownTextView.contentSize.height);
		if (self.markdownTextView.contentSize.height > self.markdownTextView.frame.size.height - self.markdownTextView.contentInset.bottom ) {
			[self.markdownTextView setContentOffset:CGPointMake(0, self.markdownTextView.contentSize.height - (self.markdownTextView.frame.size.height - self.markdownTextView.contentInset.bottom)) animated:YES];
		}

	});


}
- (void)addRAC{
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
- (void)setCurrentIndex:(NSInteger)currentIndex{
	self.segmentedControl.selectedSegmentIndex = currentIndex;
}
- (NSInteger)currentIndex{
	return self.segmentedControl.selectedSegmentIndex;
}
#pragma mark - Action

- (IBAction)switchMarkDownStateAction:(UISegmentedControl *)sender {
	[self switchMarkDownState];
}
- (void)switchMarkDownState{
	if (self.currentIndex == 0) {
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
- (IBAction)saveMarkAction:(UIBarButtonItem *)sender {
	self.currentModel.content = self.markdownTextView.text;
	self.currentModel.title = self.titleTxtField.text;
	BOOL flag = NO;
	if (self.currentModel.indexID) {
		flag = [self.currentModel update];
	}else{
		flag = [self.currentModel insert];
	}
	[self showAlert:(flag?@"保存成功":@"保存失败")];
}

- (void)showAlert:(NSString *)msg{
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
	[alert addAction:action];
	[self presentViewController:alert animated:YES completion:nil];
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
