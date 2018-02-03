//
//  HGCollectionDBModel.h
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/1/31.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGBaseModel.h"

typedef NS_ENUM(NSInteger ,HGCollectionType){
	HGCollectionTypeURL = 1,
	HGCollectionTypeWord,

};
@interface HGCollectionDBModel : HGBaseModel

@property (nonatomic ) NSInteger indexID;
@property (nonatomic, strong) NSString *collectionID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@property (nonatomic ) HGCollectionType collectionType;

@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *modifiedTime;


#pragma mark -
- (BOOL)insert;
- (BOOL)deleate;
+ (BOOL)deleteAllObjects;
- (BOOL)update;
+ (NSArray <HGCollectionDBModel *>*)getAllObjects;
+ (HGCollectionDBModel *)getUserWithId:(NSInteger)indexID;

@end




