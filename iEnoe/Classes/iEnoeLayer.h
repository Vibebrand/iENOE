//
//  iEnoeLayer.h
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright INEGI 2012. All rights reserved.
//


#import "CC3Layer.h"
#import "iEnoeWorld.h"

/** A sample application-specific CC3Layer subclass. */
@interface iEnoeLayer : CC3Layer 
{
     CGFloat startX, endX, startY, endY;
    CC3Layer * hudLayer;
}

#pragma mark Gestures
-(void) setupPanGestureRecognition;
-(IBAction)handlePanGesture:(UIPanGestureRecognizer*)sender;

-(void) setupPinchGestureRecognition;
-(IBAction)handlePinchGesture:(UIPinchGestureRecognizer*)sender;

@property(nonatomic, readonly) iEnoeWorld* world3D;

#pragma mark HUDLayer

-(CC3World*) makeHUDWorld;

-(void) openHUDFromTouchAt: (CGPoint) touchPoint;

-(void) closeHUDFromTouchAt: (CGPoint) touchPoint;

-(void) toggleHUDFromTouchAt: (CGPoint) touchPoint;

-(void) removeHUD;


@end
