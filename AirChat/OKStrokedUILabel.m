//
//  OKStrokedUILabel.m
//  AirChat
//
//  Created by Ömer Karışman on 19.10.2013.
//  Copyright (c) 2013 Okaris. All rights reserved.
//

#import "OKStrokedUILabel.h"

@implementation OKStrokedUILabel
@synthesize hasStroke;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawTextInRect:(CGRect)rect {
    

    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 2);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    if (hasStroke) {

        CGContextSetTextDrawingMode(c, kCGTextStroke);
        self.textColor = [UIColor whiteColor];
        [super drawTextInRect:rect];

    }
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
        
    
}
@end
