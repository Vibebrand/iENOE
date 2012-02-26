//
//  iEnoeAppDelegate.h
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright INEGI 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCNodeController.h"
#import "CC3World.h"
#import "VentanaPrincipal.h"

@class ControlMaestro;

@interface iEnoeAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow* window;
    VentanaPrincipal *controladorVistaPrincipal;
    
    ControlMaestro * _controlMaestro;
    void * _motorGraficasSencha;
}


@property (nonatomic, retain) UIWindow* window;

@end
