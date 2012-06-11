//
//  RepresentacionCeldaLeyendaMapa.m
//  iEnoe
//
//  Created by Jesus Cagide on 22/05/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "RepresentacionCeldaLeyendaMapa.h"

#define LEFT_COLUMN_OFFSET 8
#define LEFT_COLUMN_WIDTH 130

#define MIDDLE_COLUMN_OFFSET 140
#define MIDDLE_COLUMN_WIDTH 110

#define RIGHT_COLUMN_OFFSET 200

#define UPPER_ROW_TOP 22
#define LOWER_ROW_TOP 43

#define MAIN_FONT_SIZE 18
#define MIN_MAIN_FONT_SIZE 16
#define SECONDARY_FONT_SIZE 12
#define MIN_SECONDARY_FONT_SIZE 10

@implementation RepresentacionCeldaLeyendaMapa

@synthesize nombreLeyenda;

-(void)dealloc
{
    self.nombreLeyenda = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = YES;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    UIColor *mainTextColor = [UIColor blackColor];
    UIFont *mainFont = [UIFont systemFontOfSize:MAIN_FONT_SIZE];
    
    CGRect contentRect = self.bounds;
    
    CGFloat boundsX = contentRect.origin.x;
    CGPoint point;
    
    CGFloat actualFontSize;
    
    [mainTextColor set];

    point = CGPointMake(boundsX + 68, UPPER_ROW_TOP);
    
    [self.nombreLeyenda drawAtPoint:point forWidth:(contentRect.size.width - 70) withFont:mainFont minFontSize:actualFontSize actualFontSize:&actualFontSize lineBreakMode:UILineBreakModeTailTruncation baselineAdjustment:UILineBreakModeTailTruncation];
    
}


@end
