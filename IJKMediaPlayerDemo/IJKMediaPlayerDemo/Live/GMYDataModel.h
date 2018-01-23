//
//  GMYDataModel.h
//  YZLiveApp
//
//  Created by GMY on 2018/1/19.
//  Copyright © 2018年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GMYLiveInfoModel.h"

@interface GMYDataModel : NSObject

@property (nonatomic, strong) GMYLiveInfoModel *live_info;

@property (nonatomic, strong) NSString *redirect_type;

@end
