//
//  CeldaLeyendaMapa.m
//  iEnoe
//
//  Created by Jesus Cagide on 22/05/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "CeldaLeyendaMapa.h"

@implementation CeldaLeyendaMapa
@synthesize representacionCeldaLeyendaMapa;



-(void)dealloc
{
    self.representacionCeldaLeyendaMapa = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect tzvFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
		self.representacionCeldaLeyendaMapa = [[RepresentacionCeldaLeyendaMapa alloc] initWithFrame:tzvFrame];
		self.representacionCeldaLeyendaMapa.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self.contentView addSubview:self.representacionCeldaLeyendaMapa];
    }
    return self;
}


- (void)redisplay
{
    [self.representacionCeldaLeyendaMapa setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
