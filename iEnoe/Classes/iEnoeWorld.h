//
//  iEnoeWorld.h
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright INEGI 2012. All rights reserved.
//


#import "CC3World.h"
#import "CC3MeshNode.h"

#import "CC3PODResourceNode.h"
#import "CC3PODLight.h"
#import "CC3PointParticles.h"

@interface iEnoeWorld : CC3World 
{
    CC3PODResourceNode *_modelo3D;
    CC3Node *_nodoSeleccionado;
    GLfloat maxTop;
    GLfloat maxButton;
    GLfloat maxRigth;
    GLfloat maxLeft;

}

-(void)zoomThatThing:(CGFloat)theZoom;

-(void)spinThatThing:(CGFloat)x :(CGFloat)y;

@property(nonatomic, retain)NSString* nodoSeleccionado;

-(void)addPOD;


@end
