	//
	//  ShareViewController.m
	//  HGShare
	//
	//  Created by 小雨很美 on 2018/1/31.
	//  Copyright © 2018年 小雨很美. All rights reserved.
	//

#import "ShareViewController.h"
#import "HGCollectionDBModel.h"
@interface ShareViewController ()

@end

@implementation ShareViewController

- (BOOL)isContentValid {
		// Do validation of contentText and/or NSExtensionContext attachments here
	return YES;
}

- (void)didSelectPost {
		// This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.

		// Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.

//NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.HGINspirationNotesShare"];

	__weak typeof(self) weakSelf = self;

	[self.extensionContext.inputItems enumerateObjectsUsingBlock:^(NSExtensionItem * _Nonnull extItem, NSUInteger idx, BOOL * _Nonnull stop) {
		[extItem.attachments enumerateObjectsUsingBlock:^(NSItemProvider * _Nonnull itemProvider, NSUInteger idx, BOOL * _Nonnull stop) {
			if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"]){
				[itemProvider loadItemForTypeIdentifier:@"public.url"
												options:nil
									  completionHandler:^(NSURL *_Nullable item, NSError * _Null_unspecified error) {
										  if ([item isKindOfClass:[NSURL class]]){
											  HGCollectionDBModel *collectionModel = [[HGCollectionDBModel alloc] init];
											  collectionModel.title = weakSelf.contentText;
											  collectionModel.content = item.absoluteString;
											  collectionModel.collectionType = HGCollectionTypeURL;
											  collectionModel.createTime = [NSDate new];
											  collectionModel.modifiedTime = [NSDate new];
											  [collectionModel insert];
										  }
									  }];
			}
		}];
	}];
		//直接退出
	[self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
		// To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
	return @[];
}

@end
