//
//  iEnoeWorld.m
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright INEGI 2012. All rights reserved.
//

#import "iEnoeWorld.h"
#import "CC3PODResourceNode.h"
#import "CC3ActionInterval.h"
#import "CC3MeshNode.h"
#import "CC3Camera.h"
#import "CC3Light.h"
#import "CCTouchDispatcher.h"

@implementation iEnoeWorld

@synthesize nodoSeleccionado;

-(void) dealloc {
    
	[super dealloc];
}

-(void) drawWorld
{
    static BOOL nombre = true;
    if(nombre)
    {
        [self.activeCamera moveWithDuration:2.0 toShowAllOf:_modelo3D];
        
        maxTop = _modelo3D.boundingBox.maximum.x;
        maxButton = _modelo3D.boundingBox.minimum.x;
        
        maxLeft = _modelo3D.boundingBox.maximum.y;
        maxRigth = _modelo3D.boundingBox.minimum.y;

        nombre=false;
    }
    
    [super drawWorld];
}


-(void) initializeWorld {
    
    self.shouldClearDepthBufferBefore2D = NO;
	self.shouldClearDepthBufferBefore3D = NO;
	[[CCDirector sharedDirector] setDepthTest: NO];

    
    self.drawingSequencer = [CC3BTreeNodeSequencer sequencerLocalContentOpaqueFirst];
    
    
    CC3Camera* cam = [CC3Camera nodeWithName: @"Camara"];
	cam.location = cc3v( 0.0, 0.0, 30.0 );
	[self addChild: cam];
    
    
	CC3Light* lamp = [CC3Light nodeWithName: @"Lampara"];
	lamp.location = cc3v( -2.0, 0.0, 0.0 );
	lamp.isDirectionalOnly = NO;
	[cam addChild: lamp];
    
    [self createGLBuffers];
	[self releaseRedundantData];
	
    //self.shouldDrawAllLocalContentWireframeBoxes = YES;
    
    //self.shouldDrawAllDescriptors = YES;
    // self.shouldDrawAllLocalContentWireframeBoxes = YES;
    //self.shouldDrawAllWireframeBoxes = YES;
    
    [self addPOD];
    
    LogDebug(@"The structure of this world is: %@", [self structureDescription]);
    
    LogInfo(@"_modelo 3d %@ at %@, or %@ in 2D.", _modelo3D,
			NSStringFromCC3Vector( _modelo3D.boundingBox.maximum  ),
			NSStringFromCC3Vector(   _modelo3D.boundingBox.minimum  ));

    
}


-(void)addPOD
{    
    _modelo3D = [CC3PODResourceNode nodeWithName: @"MAPA"];
	_modelo3D.resource = [CC3PODResource resourceFromResourceFile: @"mapmexico37.pod"];
    _modelo3D.location = cc3v(0.0, 0.0, 0.0);
    //[_modelo3D addAxesDirectionMarkers];
    [_modelo3D touchEnableAll];
    
    self.ambientLight = kCC3DefaultLightColorAmbientWorld;
    [self addChild: _modelo3D];
    
    
}

-(void) touchEvent: (uint) touchType at: (CGPoint) touchPoint {
    
	switch (touchType) {
		case kCCTouchBegan:
			[touchedNodePicker pickNodeFromTouchEvent: touchType at: touchPoint];
			break;
		case kCCTouchMoved:
            
			break;
		case kCCTouchEnded:
            _nodoSeleccionado = nil;
			break;
		default:
			break;
	}
}

-(void) nodeSelected: (CC3Node*) aNode byTouchEvent: (uint) touchType at: (CGPoint) touchPoint {
    
    CC3Node * nodo = (CC3Node*)_modelo3D;
    
    
    LogInfo(@"You selected %@ at %@, or %@ in 2D.", nodo,
			NSStringFromCC3Vector( nodo.boundingBox.maximum  ),
			NSStringFromCC3Vector(   nodo.boundingBox.minimum  ));
    
	_nodoSeleccionado = aNode;
	
	aNode.shouldDrawDescriptor = false;
    
    //CCActionInterval* tintUp = [CC3TintEmissionTo actionWithDuration: 0.3f colorTo: kCCC4FCyan];
    //CCActionInterval* tintDown = [CC3TintEmissionTo actionWithDuration: 0.9f colorTo: kCCC4FBlack];
    //[aNode runAction: [CCSequence actionOne: tintUp two: tintDown]];
    
    /* CC3Vector currentVector = aNode.location;
     CC3Vector endingVector = CC3VectorAdd(currentVector, cc3v(0.0,0.0, 5));
     
     
     CCActionInterval* dropAction = [CC3MoveTo actionWithDuration: 3.0f moveTo: endingVector];
     dropAction = [CCEaseOut actionWithAction: [CCEaseIn actionWithAction: dropAction rate: 4.0f] rate: 1.6f];
     [aNode runAction:dropAction];*/
    
    [aNode setColor:ccRED];
    aNode.isOpaque = !aNode.isOpaque;
    if(!aNode.isOpaque){
        aNode.opacity =200;
        //[self.activeCamera moveWithDuration:2.0 toShowAllOf:podRezNode];
    }else
    {
        //[self.activeCamera moveWithDuration:2.0 toShowAllOf:aNode];
    }
    [self setNodoSeleccionado:[aNode name]];
    // NSLog(@"%@", aNode.opacity);
    NSLog(@"%@", self.nodoSeleccionado);
}

-(void)zoomThatThing:(CGFloat)theZoom
{
    CC3Camera *theCamera = (CC3Camera *)[self activeCamera];
    NSLog(@"%@", theCamera.name);
    
    CC3Vector currentVector = theCamera.location;

    CC3Vector endingVector = CC3VectorAdd(currentVector, cc3v(0.0, 0.0, theZoom));
    
    
    if ( endingVector.z  > 2 && endingVector.z < 10)
    {
        
        [theCamera setLocation:endingVector];
    }
}

-(void)spinThatThing:(CGFloat)x :(CGFloat)y
{
     CC3Camera *theCamera = (CC3Camera *)[self activeCamera];
    CC3Vector current = theCamera.location;
    CC3Vector increment = CC3VectorAdd(current, cc3v(x, y, 0.0));
    
    if( (increment.x + 1 ) < maxTop && (increment.x - 1) > maxButton  &&   
       (increment.y + 1) < maxLeft && (increment.y - 1) > maxRigth)
       [theCamera setLocation:increment];
    
    
    LogInfo(@"camara 3d %@ ", NSStringFromCC3Vector( theCamera.location));
}
 
-(void) updateBeforeTransform: (CC3NodeUpdatingVisitor*) visitor {}

-(void) updateAfterTransform: (CC3NodeUpdatingVisitor*) visitor {}

@end

