//
//  GMYLiveInfoModel.h
//  YZLiveApp
//
//  Created by GMY on 2018/1/19.
//  Copyright © 2018年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GMYCreatorModel.h"

@interface GMYLiveInfoModel : NSObject

/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 主播 */
@property (nonatomic, strong) GMYCreatorModel *creator;

@end
