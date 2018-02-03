//
//  HGCollectionViewController.m
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/31.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGCollectionViewController.h"
#import "HGCollectionDBModel.h"
#import "HGCollectionTableViewCell.h"

#import "HGShowWebViewController.h"
#import "HGMarkDownViewController.h"
#import <YYCategories/NSString+YYAdd.h>
@interface HGCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray <HGCollectionDBModel *>*dataSource;
@end

@implementation HGCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//
//	HGCollectionDBModelManager *manager = [HGCollectionDBModelManager shareInstance];
//
//	[manager creatDataBase];
//	[manager insertCollection];
//	NSArray *array = [manager seleteCollection];
//	https://www.jianshu.com/p/5cf460069ecd flex

//	http://blog.csdn.net/pengyuan_d/article/details/40987709 hpple
	self.dataSource = [HGCollectionDBModel getAllObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)refreshListAction:(UIBarButtonItem *)sender {
	self.dataSource = [HGCollectionDBModel getAllObjects];
	[self.tableView reloadData];
}

- (IBAction)addMarkdown:(UIBarButtonItem *)sender {
	HGCollectionDBModel *model = [[HGCollectionDBModel alloc] init];
	model.collectionType = HGCollectionTypeWord;
	model.createTime = [NSDate new];
	model.collectionID = [model.createTime.description md5String];
	[self performSegueWithIdentifier:@"collectionToMarkdown" sender:model];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(HGCollectionDBModel *)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
	if ([segue.identifier isEqualToString:@"collectionToWebview"]) {
		HGShowWebViewController *webView = segue.destinationViewController;
		webView.urlStr = sender.content;
	}else if ([segue.identifier isEqualToString:@"collectionToMarkdown"]){
		HGMarkDownViewController *markView = segue.destinationViewController;
		markView.currentIndex = 1;
		markView.currentModel = sender;
	}
}


#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	HGCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	[cell refreshCell:self.dataSource[indexPath.row]];
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

	[self showCollection:self.dataSource[indexPath.row]];
}
- (void)showCollection:(HGCollectionDBModel *)model{
		//	collectionToMarkdown
		//	collectionToWebview
	if (model.collectionType == HGCollectionTypeURL) {
		[self performSegueWithIdentifier:@"collectionToWebview" sender:model];
	}else if (model.collectionType == HGCollectionTypeWord){
		[self performSegueWithIdentifier:@"collectionToMarkdown" sender:model];
	}
}



@end
