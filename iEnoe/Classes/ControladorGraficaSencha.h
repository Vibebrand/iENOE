//
//  ControladorGraficaSencha.h
//  iEnoe
//
//  Created by Luis Rangel on 23/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControladorSencha.h"
#import "iControladorVista.h"
#import "NativeBridgeDelegate.h"

@interface ControladorGraficaSencha : UIView <iControladorVista, NativeBridgeDelegate>


- (void)handleCall:(NSString*)functionName callbackId:(int)callbackId args:(NSArray*)args webView: (UIWebView *)webView andNativeBridge: (id<INativeBridge>) nativeBridge;

-(UIView *) obtenerRepresentacionBajoMarco:(CGRect) tamanioVentana;
-(UIView *) obtenerRepresentacion;
-(IBAction) accionarLeyendas:(id)sender;

@property(nonatomic , assign)IBOutlet UILabel *etiquetaNombregrafica;
@property(nonatomic , assign)IBOutlet UIWebView *navegadorWeb;
@property(nonatomic , assign)IBOutlet UIView * vistaPadre;
@property(nonatomic, retain) ControladorSencha * controladorSencha;


@end
