//
//  GMYLiveCell.m
//  IJKMediaPlayerDemo
//
//  Created by GMY on 2018/1/23.
//  Copyright © 2018年 gmy. All rights reserved.
//

#import "GMYLiveCell.h"

#import <UIImageView+WebCache.h>

#import "GMYCardModel.h"

@implementation GMYLiveCell

- (void)setCardModel:(GMYCardModel *)cardModel {
    _cardModel = cardModel;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cardModel.data.live_info.creator.portrait] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.textLabel.text = cardModel.data.live_info.creator.nick;
    self.detailTextLabel.text = [NSString stringWithFormat:@"关注人数：%zd", cardModel.data.live_info.online_users];
}

- (void)setFrame:(CGRect)frame{
    CGFloat separatorLine = 5;
    frame.origin.y += separatorLine;
    frame.size.height -= separatorLine * 2;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
