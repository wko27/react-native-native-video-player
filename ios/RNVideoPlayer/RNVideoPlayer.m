//
//  RNVideoPlayer.m
//  RNVideoPlayer
//
//  Created by DC5 Admin (MACMINI032) on 10/25/16.
//  Copyright © 2016 DC5 Admin (MACMINI032). All rights reserved.
//

#import "RNVideoPlayer.h"

@implementation RNVideoPlayer

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(showVideoPlayer: (NSString*) url)
{
    self.videoURL = [NSURL URLWithString:url];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:_videoURL];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    self.playerViewController = [AVPlayerViewController new];
    _playerViewController.player = player;
    [_playerViewController setModalPresentationStyle:UIModalPresentationFullScreen];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (viewController.presentedViewController)
        {
            viewController = viewController.presentedViewController;
        }
        
        [viewController presentViewController:_playerViewController animated:true completion:^{
            _playerViewController.showsPlaybackControls = YES;
        }];
    });
    
    [_playerViewController.player play];
}

@end

