//
//  GMYLiveViewController.m
//  IJKMediaPlayerDemo
//
//  Created by GMY on 2018/1/23.
//  Copyright © 2018年 gmy. All rights reserved.
//

#import "GMYLiveViewController.h"

#import <UIImageView+WebCache.h>

#import <IJKMediaFramework/IJKMediaFramework.h>

@interface GMYLiveViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation GMYLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置直播占位图片
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",self.cardModel.data.live_info.creator.portrait]];
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:nil];
    
    // 拉流地址
    NSURL *url = [NSURL URLWithString:self.cardModel.data.live_info.stream_addr];
    
    // 创建IJKFFMoviePlayerController：专门用来直播，传入拉流地址就好了
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    
    // 准备播放
    [playerVc prepareToPlay];
    
    // 强引用，反正被销毁
    _player = playerVc;
    
    playerVc.view.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:playerVc.view atIndex:1];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 界面消失，一定要记得停止播放
    [_player pause];
    [_player stop];
    [_player shutdown];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
