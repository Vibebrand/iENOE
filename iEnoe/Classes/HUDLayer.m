//
//  HUDLayer.m
//  iEnoe
//
//  Created by Jesus Cagide on 29/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "HUDLayer.h"
#import "iEnoeLayer.h"
@implementation HUDLayer

-(void) initializeControls {
    
	self.isTouchEnabled = YES;
}

-(BOOL) handleTouchType: (uint) touchType at: (CGPoint) touchPoint {
	switch (touchType) {
		case kCCTouchEnded:
			[((iEnoeLayer*)self.parent) toggleHUDFromTouchAt: touchPoint];
			break;
		default:
			break;
	}
	return YES;
}



@end
