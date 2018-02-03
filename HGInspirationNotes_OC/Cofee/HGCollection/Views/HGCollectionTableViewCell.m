//
//  HGCollectionTableViewCell.m
//  HGInspirationNotes_OC
//
//  Created by 小雨很美 on 2018/2/2.
//  Copyright © 2018年 小雨很美. All rights reserved.
//

#import "HGCollectionTableViewCell.h"
@interface HGCollectionTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UILabel *tagL;


@end
@implementation HGCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshCell:(HGCollectionDBModel *)model{
	self.titleL.text = @"myway";
	self.contentL.text =  model.title;
	self.dateL.text = [model.modifiedTime description];
	switch (model.collectionType) {
		case HGCollectionTypeURL:
			self.tagL.text = @"URL";
			break;
			case HGCollectionTypeWord:
			self.tagL.text = @"Markdown";
		default:
			break;
	}

}
@end
