//
//  HGCollectionDBModel.m
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/31.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGCollectionDBModel.h"

#import "HGCollectionDBModel+WCTTableCoding.h"


@implementation HGCollectionDBModel

WCDB_IMPLEMENTATION(HGCollectionDBModel)//使用WCDB_IMPLEMENTATIO宏在类文件定义绑定到数据库表的类。

WCDB_SYNTHESIZE(HGCollectionDBModel, indexID)//使用WCDB_SYNTHESIZE宏在类文件定义需要绑定到数据库表的字段。
WCDB_SYNTHESIZE(HGCollectionDBModel, collectionID)
WCDB_SYNTHESIZE(HGCollectionDBModel, title)
WCDB_SYNTHESIZE(HGCollectionDBModel, content)
WCDB_SYNTHESIZE(HGCollectionDBModel, collectionType)
WCDB_SYNTHESIZE(HGCollectionDBModel, createTime)
WCDB_SYNTHESIZE(HGCollectionDBModel, modifiedTime)

//WCDB_PRIMARY(HGCollectionDBModel, indexID)//用于定义主键
WCDB_PRIMARY_ASC_AUTO_INCREMENT(HGCollectionDBModel, indexID) //用于定义主键且自增。
WCDB_UNIQUE(HGCollectionDBModel, collectionID)//用于定义唯一约束
//WCDB_UNIQUE(HGCollectionDBModel, indexID)//用于定义唯一约束
//WCDB_NOT_NULL(HGCollectionDBModel, indexID)//用于定义非空约束
WCDB_INDEX(HGCollectionDBModel, "_index", indexID)//用于定义索引

+ (WCTTable *)shareTable{

	static WCTTable *instanceTB = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		WCTDatabase *instanceDB = [[WCTDatabase alloc]initWithPath:[self dbPath]];
		[instanceDB createTableAndIndexesOfName:NSStringFromClass(self) withClass:self];

		[instanceDB createTableAndIndexesOfName:NSStringFromClass(HGCollectionDBModel.class) withClass:HGCollectionDBModel.class];
		instanceTB    = [instanceDB getTableOfName:NSStringFromClass(HGCollectionDBModel.class) withClass:HGCollectionDBModel.class];
	});
	return instanceTB;
}


- (BOOL)isAutoIncrement{
	return YES;
}
#pragma mark -
- (BOOL)insert{
	 BOOL flag = [[HGCollectionDBModel shareTable] insertObject:self];
	if (flag && self.collectionID) {
		HGCollectionDBModel *model = [[HGCollectionDBModel shareTable] getOneObjectWhere:HGCollectionDBModel.collectionID == self.collectionID] ;
		self.indexID = model.indexID;
	}
	return flag;
}
- (BOOL)deleate{
	return [[HGCollectionDBModel shareTable] deleteObjectsWhere:HGCollectionDBModel.indexID == self.indexID];
}
+ (BOOL)deleteAllObjects{
	return [[HGCollectionDBModel shareTable] deleteAllObjects];
}
- (BOOL)update{
	return [[HGCollectionDBModel shareTable] updateRowsOnProperties:HGCollectionDBModel.AllProperties withObject:self where:HGCollectionDBModel.indexID == self.indexID];
//	[[HGCollectionDBModel shareTable] updateRowsOnProperties:{HGCollectionDBModel.modifiedTime,HGCollectionDBModel.content} withObject:self where:HGCollectionDBModel.indexID == self.indexID];
}

+ (NSArray <HGCollectionDBModel *>*)getAllObjects{
	return [[HGCollectionDBModel shareTable] getAllObjects];
}

+ (HGCollectionDBModel *)getUserWithId:(NSInteger)indexID
{
	return [[[HGCollectionDBModel shareTable] getObjectsWhere:HGCollectionDBModel.indexID == indexID] firstObject];
}

@end


