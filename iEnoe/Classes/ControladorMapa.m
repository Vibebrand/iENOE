//
//  ControladorMapa.m
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "ControladorMapa.h"
#import "CC3OpenGLES11Engine.h";

@implementation ControladorMapa

@synthesize director;

-(void)dealloc
{
    [_glView release];
    //self.director = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.director = [CCDirector sharedDirector];
    

    _glView = [CC3EAGLView viewWithFrame: [[self view] bounds] 
									  pixelFormat: kEAGLColorFormatRGBA8
									  depthFormat: GL_DEPTH_COMPONENT16_OES
							   preserveBackbuffer: NO
									   sharegroup: nil
									multiSampling: NO
								  numberOfSamples: 4];

	[_glView setMultipleTouchEnabled: YES];
    
    _glView.backgroundColor = [UIColor clearColor];
    _glView.opaque = YES;
    [CC3OpenGLES11Engine engine].state.clearColor.value= kCCC4FBlackTransparent;
    
	[director setOpenGLView:_glView];
    
    [[self view] insertSubview:_glView atIndex:0];
    
    CC3Layer* cc3Layer = [iEnoeLayer node];
	
    [cc3Layer scheduleUpdate];
	
    cc3Layer.cc3World = [iEnoeWorld world];
    
	ControllableCCLayer* mainLayer = cc3Layer;
    
    CCScene *scene = [CCScene node];
    
    [scene addChild: mainLayer];
    
    [[self director] runWithScene:scene];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


#pragma mark iControladorVista
-(UIView *) obtenerRepresentacionBajoMarco:(CGRect) tamanioVentana
{
    return [self view];
}

-(UIView *) obtenerRepresentacion
{
    return [self view];
}

@end
