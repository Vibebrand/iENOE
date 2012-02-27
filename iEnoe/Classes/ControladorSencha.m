//
//  ControladorSencha.m
//  iGlobo
//
//  Created by Jesus Cagide on 09/12/11.
//  Copyright (c) 2011 INEGI. All rights reserved.
//

#import "ControladorSencha.h"
#import <QuartzCore/QuartzCore.h>

@implementation ControladorSencha

@synthesize webView;
@synthesize nativeBridge;
@synthesize nativeBridgeDelegate;
@synthesize vistaPrincipal;
- (id)init {
    self = [super init];
    if (self) {
        inicializado = false;
    }
    return self;
}

- (void)dealloc {
    [[self webView] setDelegate: nil];
    [self setWebView: nil];
    [self setNativeBridgeDelegate:nil];
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [[self webView] setDelegate: [self nativeBridge]];
    [[self nativeBridge] setDelegate: self];
    
    // Carga de html en webView
    NSString * startFilePath = [self pathForResource:@"index.html"];
    NSURL *appURL = [NSURL fileURLWithPath:startFilePath];
    NSURLRequest *appReq = [NSURLRequest requestWithURL:appURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    [[self webView] loadRequest:appReq];
}

- (NSString*) pathForResource:(NSString*)resourcepath
{
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSMutableArray *directoryParts = [NSMutableArray arrayWithArray:[resourcepath componentsSeparatedByString:@"/"]];
    NSString       *filename       = [directoryParts lastObject];
    [directoryParts removeLastObject];
    
    NSString* directoryPartsJoined =[directoryParts componentsJoinedByString:@"/"];
    NSString* directoryStr = @"www";
    
    if ([directoryPartsJoined length] > 0) {
        directoryStr = [NSString stringWithFormat:@"%@/%@", @"www", [directoryParts componentsJoinedByString:@"/"]];
    }
    
    return [mainBundle pathForResource:filename
                                ofType:@""
                           inDirectory:directoryStr];
}

- (BOOL)handleCall:(NSString*)functionName callbackId:(int)callbackId args:(NSArray*)args webView: (UIWebView *)_webView andNativeBridge: (id<INativeBridge>) _nativeBridge {
    BOOL salida = NO;
    
    salida = [[self nativeBridgeDelegate ] handleCall:functionName callbackId:callbackId args:args webView:_webView andNativeBridge:_nativeBridge];
    
    if(salida == NO) {
        NSDictionary * diccionarioElementos = [args count] ? [args objectAtIndex: 0] : nil;
        
        if([functionName isEqualToString: @"serieActualizada" ]) {
            // Generar notificacion    
            if(diccionarioElementos) {
                NSString * nuevaLlave = [diccionarioElementos objectForKey: @"valor"];
                NSString * nuevoValor = [[diccionarioElementos objectForKey: @"oculto"] isEqualToString: @"true"] 
                                            ? @"0" 
                                            : @"1";
                [self estableceValor:nuevoValor aVariable: nuevaLlave requiereActualizacion: YES];
            }
        } else if([functionName isEqualToString: @"estableceVariable"]) {
            if(diccionarioElementos) {
                NSString * nuevaLlave = [diccionarioElementos objectForKey: @"variable"];
                NSString * nuevoValor = [diccionarioElementos objectForKey: @"valor"];
                BOOL actualizar = [[diccionarioElementos objectForKey: @"actualizar"] isEqualToString: @"true"] 
                                            ? YES 
                                            : NO;
                
                [self estableceValor:nuevoValor aVariable: nuevaLlave requiereActualizacion: actualizar];
            }
        }
    }
    
    return salida;
}

- (void) estableceValor: (NSString *) valor aVariable: (NSString *) variable requiereActualizacion: (BOOL) actualizar {
    NSNotification * myNotification =
    [NSNotification notificationWithName:@"estableceVariable" 
                                  object:self 
                                userInfo: [NSDictionary dictionaryWithObjectsAndKeys: variable, @"llave", 
                                                                                         valor, @"valor", 
                                                  [NSNumber numberWithInt: actualizar ? 1 : 0], @"actualizar" , nil]];
    
    [[NSNotificationQueue defaultQueue] enqueueNotification: myNotification
                                               postingStyle: NSPostWhenIdle
                                               coalesceMask: NSNotificationNoCoalescing
                                                   forModes: nil];
}

- (bool) requiereInicializacion {
    // TODO Dar mas inteligencia a la inicializacion
    bool salida = inicializado;
    if(!inicializado)
        inicializado = true;
    return !salida;
}

- (void) estableceVistaRequerida: (bool) requerida {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.90;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.vistaPrincipal.layer addAnimation:transition forKey:nil];
    
    [self.vistaPrincipal setHidden:!requerida];
    [[self webView] setHidden: !requerida];
}

- (void) ejecutaInstruccion: (NSString *) instruccion {
    [[self webView] performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject: instruccion waitUntilDone: NO];
}

@end
