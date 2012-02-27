//
//  ControladorSencha.h
//  iGlobo
//
//  Created by Jesus Cagide on 09/12/11.
//  Copyright (c) 2011 INEGI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NativeBridge.h"
#import "NativeBridgeDelegate.h"
#import "IRepresentableSenchaDelegado.h"

@interface ControladorSencha : NSObject <NativeBridgeDelegate, IRepresentableSenchaDelegado>
{
    bool inicializado;
}
- (void)viewDidLoad;

- (BOOL)handleCall:(NSString*)functionName callbackId:(int)callbackId args:(NSArray*)args webView: (UIWebView *)webView andNativeBridge: (id<INativeBridge>) nativeBridge;

- (NSString*) pathForResource:(NSString*)resourcepath;


- (bool) requiereInicializacion;
- (void) estableceVistaRequerida: (bool) requerida;
- (void) ejecutaInstruccion: (NSString *) instruccion;
- (void) estableceValor: (NSString *) valor aVariable: (NSString *) variable requiereActualizacion: (BOOL) actualizar;

@property(nonatomic, assign) id<NativeBridgeDelegate> nativeBridgeDelegate;
@property(nonatomic, retain) NativeBridge * nativeBridge;
@property(nonatomic, assign) UIWebView * webView;
@property(nonatomic, assign) UIView * vistaPrincipal;

@end
