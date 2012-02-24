//
//  iEnoeLayer.m
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright INEGI 2012. All rights reserved.
//

#import "iEnoeLayer.h"

@interface CC3Layer (TemplateMethods)
-(BOOL) handleTouch: (UITouch*) touch ofType: (uint) touchType;
@end

@implementation iEnoeLayer

@synthesize world3D;

-(iEnoeWorld*) world3D {
	return (iEnoeWorld*) self.cc3World;
}

- (void)dealloc {
    [super dealloc];
}

-(void) initializeControls 
{
    self.isTouchEnabled = YES;
    [self setupPanGestureRecognition];
    [self setupPinchGestureRecognition];
}

-(void) setupPanGestureRecognition
{
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    
    [panGesture setMinimumNumberOfTouches:1];
	[panGesture setMaximumNumberOfTouches:1];
    
	[[[CCDirector sharedDirector] openGLView] addGestureRecognizer:panGesture];
	[panGesture release];
    
    
}
-(IBAction)handlePanGesture:(UIPanGestureRecognizer*)sender
{
    
    CCDirector *director = [CCDirector sharedDirector]; 
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        
        CGPoint tp = [(UIPanGestureRecognizer*)sender locationOfTouch:0 inView:[director openGLView]];
        CGFloat delX = tp.x - startX;
        CGFloat delY = - tp.y + startY;
        startX = tp.x; startY = tp.y;
        
        delY = delY* -0.01;
        delX = delX* -0.01;
        
        [[self world3D] spinThatThing:delX :delY];
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        CGPoint tp =  [(UIPanGestureRecognizer*)sender locationOfTouch:0 inView:[director openGLView]];
        startX = tp.x;
        startY = tp.y;
    }
}

-(void) setupPinchGestureRecognition
{
    
    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    
	[[[CCDirector sharedDirector] openGLView] addGestureRecognizer:pinchGesture];
	[pinchGesture release];
}


-(IBAction)handlePinchGesture:(UIPinchGestureRecognizer*)sender
{
    CGFloat currentScale = [(UIPinchGestureRecognizer*)sender scale];
    CGFloat display = (1-currentScale);
    [[self world3D ] zoomThatThing:display];
    NSLog(@"activado pinch");
    
}

// Handles intermediate finger-moved touch events. 
-(void) ccTouchMoved: (UITouch *)touch withEvent: (UIEvent *)event {
	[self handleTouch: touch ofType: kCCTouchMoved];
}



@end
