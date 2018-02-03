//
//  HGBaseModel.m
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/31.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGBaseModel.h"

	//FOUNDATION_EXPORT NSString * const hg_myway_db;
NSString * const hg_myway_db = @"hg_myway_db.db";
@implementation HGBaseModel

+ (NSString *)dbPath{

	//	通过containerURLForSecurityApplicationGroupIdentifier方法和共享域标识符我们可以获取到该共享域的路径
	NSURL *path = [[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.HGINspirationNotesShare"] URLByAppendingPathComponent:hg_myway_db];

//		NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

	return path.path;

////	获取沙盒根目录
//	NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
////	文件路径
//	return  [documentsPath stringByAppendingPathComponent:hg_myway_db];
}
@end
