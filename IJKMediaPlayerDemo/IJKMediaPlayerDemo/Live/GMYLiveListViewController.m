//
//  GMYLiveListViewController.m
//  IJKMediaPlayerDemo
//
//  Created by GMY on 2018/1/23.
//  Copyright © 2018年 gmy. All rights reserved.
//

#import "GMYLiveListViewController.h"

#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

#import "GMYLiveCell.h"
#import "GMYCardModel.h"
#import "GMYDataModel.h"
#import "GMYLiveInfoModel.h"

#import "GMYLiveViewController.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface GMYLiveListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation GMYLiveListViewController

static NSString *cellID = @"cellID";

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGFloat topSafeMargin = SCREEN_SIZE.height == 812.0 ? 88 : 64;
        CGFloat bottomSafeMargin = SCREEN_SIZE.height == 812.0 ? 34 : 0;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topSafeMargin, SCREEN_SIZE.width, SCREEN_SIZE.height - topSafeMargin - bottomSafeMargin)];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GMYLiveCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

-(NSMutableArray *)cards {
    if (_cards == nil) {
        _cards = [NSMutableArray array];
    }
    return _cards;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Live";
    
    [self setupRefresh];
}

- (void)setupRefresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRecommend)];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadRecommend {
    NSString *urlStr = @"https://service.inke.cn/api/live/card_recommend?cc=TG36008&lc=3d94f14ce53423d8&mtxid=089b4b952931&devi=866413035330040&sid=20NUdhKaou2q1fyi1bgc1xjkHdtmi1Hfv6knjToVoi1i1C1m2f2Htz&osversion=android_25&cv=IK5.2.10_Android&imei=866413035330040&proto=8&conn=wifi&ua=XiaomiMiNote3&logid=268%2C208%2C233%2C236&icc=898600c10116f0019236&uid=625372547&ast=1&vv=1.0.3-201610121413.android&aid=b2890515ddd8dcd8&smid=Duj5Blmq%2FuE9yFJvo976IB9iPuIm8wiA%2BT44mlfPMOkkESCMUikDY%2BXRVi%2Fw19jXX%2F0L2XQjWNd0KnkPUyuXep3w&imsi=460022104850757&mtid=a872304ba7e291d12698e2c14bce61a0&card_pos=2&longitude=116.4701&refurbish_mode=0&live_uid=22635514&crv=1.0&gender=3&user_level=0&slide_pos=0&interest=0&location=CN%2C%E5%8C%97%E4%BA%AC%E5%B8%82%2C%E5%8C%97%E4%BA%AC%E5%B8%82&latitude=39.934425&stay_time=0&type=0&r_c=r171227378&s_sg=vv5de2e8110cdf46f928d384bd09342be5&s_sc=101&s_st=1516357592";
    
    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
//        NSLog(@"%@", responseObject);
        self.cards = [GMYCardModel mj_objectArrayWithKeyValuesArray:responseObject[@"cards"]];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GMYLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.cardModel = self.cards[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GMYLiveViewController *liveVC = [[GMYLiveViewController alloc] init];
    liveVC.cardModel = self.cards[indexPath.row];
    [self presentViewController:liveVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
