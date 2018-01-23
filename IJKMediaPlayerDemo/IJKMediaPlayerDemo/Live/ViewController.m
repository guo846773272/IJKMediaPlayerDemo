//
//  ViewController.m
//  IJKMediaPlayerDemo
//
//  Created by GMY on 2018/1/23.
//  Copyright © 2018年 gmy. All rights reserved.
//

#import "ViewController.h"

#import "GMYLiveListViewController.h"
#import "GMYCaptureViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)captureVideoClick:(id)sender {
    GMYCaptureViewController *captureVC = [[GMYCaptureViewController alloc] init];
    [self.navigationController pushViewController:captureVC animated:YES];
}


- (IBAction)skipToLiveListVCClick:(id)sender {
    
    GMYLiveListViewController *liveListVC = [[GMYLiveListViewController alloc] init];
    [self.navigationController pushViewController:liveListVC animated:YES];
}

@end
