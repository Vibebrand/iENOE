//
//  iEnoeAppDelegate.m
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright INEGI 2012. All rights reserved.
//

#import "cocos2d.h"

#import "iEnoeAppDelegate.h"
#import "iEnoeLayer.h"
#import "iEnoeWorld.h"
#import "CC3EAGLView.h"

#import "VentanaPrincipal.h"
#import "ControladorMapa.h"
#import "ControladorGraficaSencha.h"
#import "MotorSenchaAPI.h"
#import "RepresentableSencha.h"
#import "ControlMaestro.h"

@implementation iEnoeAppDelegate

@synthesize window;

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[controladorVistaPrincipal release];
	[super dealloc];
}

- (void) applicationDidFinishLaunching:(UIApplication*)application {
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	CCDirector *director = [CCDirector sharedDirector];

	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//[director setDeviceOrientation:kCCDeviceOrientationLandscapeRight];

	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];
    
    controladorVistaPrincipal = [[VentanaPrincipal alloc] initWithNibName:@"VentanaPrincipal" bundle:[NSBundle mainBundle]];
    
    [ controladorVistaPrincipal setControladorMapa:[[[ControladorMapa alloc] initWithNibName:@"ControladorMapa" bundle:[NSBundle mainBundle]] autorelease] ];
    

    // Registro Control Maestro
    
    _controlMaestro = [ControlMaestro new];
    [_controlMaestro estableceVariable:@"Pais" valor:@""];
    [_controlMaestro estableceVariable:@"Entidad federativa" valor:@""];
    [_controlMaestro estableceVariable:@"Fecha" valor:@""];
    
    
    // Registro Motor Sencha
    
    MotorGraficasSencha::MotorGraficasSencha * motorGraficasSencha = new MotorGraficasSencha::MotorGraficasSencha;
    
    ControladorSencha * controladorSenchaArea = [[ControladorSencha new] autorelease];
    [controladorSenchaArea setNativeBridge: [[NativeBridge new] autorelease]];
    
    MotorGraficasSencha::IRepresentableSencha * representableSencha = new RepresentableSencha(controladorSenchaArea);
    
    motorGraficasSencha->registraRepresentable(representableSencha, 
                                               "Porcentaje de la poblacion segun caracteristica economica", 
                                               MotorGraficasSencha::MotorGraficasSencha::Area);

    [_controlMaestro registraGestorCpp: motorGraficasSencha];
    
    
    // Registro Vista
    
    ControladorGraficaSencha * controladorGraficaSenchaArea = [[[ControladorGraficaSencha alloc] initWithNibName:@"ControladorGraficaSencha" bundle: [NSBundle mainBundle] yControladorSencha:controladorSenchaArea] autorelease];
    
    [controladorVistaPrincipal setControladorGraficaArea: controladorGraficaSenchaArea];
    
    [_controlMaestro cargaArchivos];
    
    [self performSelectorOnMainThread:@selector(postLaunch:) withObject:nil waitUntilDone:NO];
}


- (void)postLaunch:(NSObject *)what
{
    // Add the view controller's view to the window and display.
    //[[_pantallaPrincipal representacionGlobo] addSubview:_controladorRepresentacionGlobo.view];
	[window addSubview: [controladorVistaPrincipal view]];
	[window makeKeyAndVisible];
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
    [_controlMaestro actualizaSecciones];
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
    [controladorVistaPrincipal release];
    
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

@end
