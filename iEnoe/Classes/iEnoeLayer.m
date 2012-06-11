//
//  iEnoeLayer.m
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright INEGI 2012. All rights reserved.
//

#import "iEnoeLayer.h"

#import "CCTouchDispatcher.h"
#import "CC3ActionInterval.h"
#import "HUDLayer.h"
#define kHUDPadding					8

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


#pragma mark HUDLayer
-(void) openHUDFromTouchAt: (CGPoint) touchPoint
{
    if (hudLayer) return;
    NSString* nombreNodoSelecionado = self.world3D.nodoSeleccionado;
	if([nombreNodoSelecionado length]>0 )
    {
        // Determine an appropriate size for the HUD child window.
        CGSize mySize = self.contentSize;
        GLfloat hudSide = MIN(mySize.width, mySize.height) * 0.5 - (kHUDPadding * 2);
        CGPoint hudPos = ccp(mySize.width - (hudSide + kHUDPadding),
                             mySize.height - (hudSide + kHUDPadding));
        CGSize hudSize = CGSizeMake(hudSide, hudSide);
        
        // Create the HUD CC3Layer, with a semi-transparent background, set its position
        // to the touch-point (offset by the size of the layer), and set its final size.
        // Start it with a small scale.
        hudLayer = [HUDLayer layerWithColor: CCC4BFromCCC4F(ccc4f(1.0, 1.0, 1.0, 0.2))];
        hudLayer.position = ccpSub(touchPoint, ccpMult(ccpFromSize(hudSize), 0.5));
        hudLayer.contentSize = hudSize;
        hudLayer.scale = 0.1;
        [hudLayer scheduleUpdate];
        
        // Create and add a new CC3World, containing just a copy of the rotating globe,
        // for the HUD layer, and ensure its camera frames the globe.
        hudLayer.cc3World = [self makeHUDWorld];
        [hudLayer.cc3World.activeCamera moveToShowAllOf: [hudLayer.cc3World getNodeNamed:nombreNodoSelecionado ] withPadding: -0.1f];
        
        // Run actions to move and scale the HUD layer from its starting position
        // and size to its final expanded position and size.
        [hudLayer runAction: [CCMoveTo actionWithDuration: 1.0 position: hudPos]];
        [hudLayer runAction: [CCScaleTo actionWithDuration: 1.0 scale: 1.0]];
        [self addChild: hudLayer];
    }
}

-(CC3World*) makeHUDWorld {
	CC3World* hudWorld = [CC3World nodeWithName: @"HUDWorld"];
    
	// Create the camera, place it back a bit, and add it to the world
	CC3Camera* cam = [CC3Camera nodeWithName: @"Camera"];
	cam.location = cc3v( 0.0, 0.0, 1.0 );
	[hudWorld addChild: cam];
	
	// Create a light and attach it to the camera.
	CC3Light* lamp = [CC3Light nodeWithName: @"Lamp"];
	[cam addChild: lamp];
	
	CC3Node* globe = [[self.cc3World getNodeNamed: self.world3D.nodoSeleccionado ] copyAutoreleased];
    self.world3D.nodoSeleccionado = nil;
	globe.location = kCC3VectorZero;
	globe.rotation = kCC3VectorZero;
	[globe runAction: [CCRepeatForever actionWithAction: [CC3RotateBy actionWithDuration: 1.0
																				rotateBy: cc3v(30.0, 0.0, 0.0)]]];
	[hudWorld addChild: globe];	
    
	[hudWorld createGLBuffers];		// Won't really do anything because the Globe mesh...
    // ...has already been buffered in main world
	hudWorld.opacity = 200;			// Makes everything in the world somewhat translucent
	return hudWorld;
}


-(void) closeHUDFromTouchAt: (CGPoint) touchPoint
{
    [hudLayer stopAllActions];
	CCActionInterval* fadeLayer = [CCFadeTo actionWithDuration: 1.0 opacity: 0];
	CCActionInterval* fadeWorld = [CCFadeTo actionWithDuration: 1.0 opacity: 0];
	CCActionInstant* removeHUDLayer = [CCCallFunc actionWithTarget: self
													 selector: @selector(removeHUD)];
	[hudLayer runAction: [CCSequence actionOne: fadeLayer two: removeHUDLayer]];
	[hudLayer.cc3World runAction: fadeWorld];
    
}

-(void) toggleHUDFromTouchAt: (CGPoint) touchPoint
{
    if (hudLayer) {
		[self closeHUDFromTouchAt: touchPoint];
	} else {
		[self openHUDFromTouchAt: touchPoint];
	}
    
}

-(void) removeHUD
{
    if (hudLayer) {
		[self removeChild: hudLayer cleanup: YES];
		hudLayer = nil;
	}
}



@end
