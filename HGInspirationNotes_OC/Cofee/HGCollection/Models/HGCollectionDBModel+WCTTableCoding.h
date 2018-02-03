//
//  HGCollectionDBModel+WCTTableCoding.h
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/31.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGCollectionDBModel.h"
#import <WCDB/WCDB.h>
@interface HGCollectionDBModel (WCTTableCoding)<WCTTableCoding>
WCDB_PROPERTY(indexID)//使用WCDB_PROPERTY宏在头文件声明需要绑定到数据库表的字段。
WCDB_PROPERTY(collectionID)
WCDB_PROPERTY(title)
WCDB_PROPERTY(content)
WCDB_PROPERTY(collectionType)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(modifiedTime)


@end

