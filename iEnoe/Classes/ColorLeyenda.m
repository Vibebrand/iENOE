//
//  ColorLeyenda.m
//  iEnoe
//
//  Created by Jesus Cagide on 23/05/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "ColorLeyenda.h"

@implementation ColorLeyenda

@synthesize nombre;
@synthesize color;

-(void)dealloc
{
    self.nombre = nil;
    self.color = nil;
    [super dealloc];
}


@end
