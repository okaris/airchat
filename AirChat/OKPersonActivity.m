//
//  OKPersonActivity.m
//  AirChat
//
//  Created by Ömer Karışman on 20.10.2013.
//  Copyright (c) 2013 Okaris. All rights reserved.
//

#import "OKPersonActivity.h"

@implementation OKPersonActivity
@synthesize activityImage,activityTitle,delegate;

- (NSString *)activityType
{
    return @"AirChat.Send";
}

- (NSString *)activityTitle
{
    return activityTitle;
}

- (UIImage *)activityImage
{
    return activityImage;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    NSLog(@"%s",__FUNCTION__);
}

- (UIViewController *)activityViewController
{
    NSLog(@"%s",__FUNCTION__);
    return nil;
}

- (void)performActivity
{
    // This is where you can do anything you want, and is the whole reason for creating a custom
    // UIActivity
    [[self delegate] didChooseActivity:self];
    [self activityDidFinish:YES];
}
@end
