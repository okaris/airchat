//
//  OKPersonActivity.h
//  AirChat
//
//  Created by Ömer Karışman on 20.10.2013.
//  Copyright (c) 2013 Okaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OKPersonactivityDelegate <NSObject>
@required
- (void) didChooseActivity:(UIActivity *)activity;
@end

@interface OKPersonActivity : UIActivity
@property (nonatomic,retain) UIImage *activityImage;
@property (nonatomic,retain) NSString *activityTitle;
@property (retain) id delegate;
@end
