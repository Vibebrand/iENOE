//
//  ControladorGraficaSencha.m
//  iEnoe
//
//  Created by Luis Rangel on 23/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//
#import "ControladorGraficaSencha.h"
#import "NativeBridge.h"

@implementation ControladorGraficaSencha

@synthesize  etiquetaNombregrafica;
@synthesize navegadorWeb;
@synthesize controladorSencha;
@synthesize vistaPadre;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setControladorSencha:[[ControladorSencha new] autorelease]];
        [[self controladorSencha ] setNativeBridge:[[NativeBridge new] autorelease]];
        [[self controladorSencha] setNativeBridgeDelegate: self];
        
        [self setBackgroundColor: [UIColor yellowColor]];
        
        self.navegadorWeb = [[[UIWebView alloc] initWithFrame: frame] autorelease];
        [self.navegadorWeb setBackgroundColor: [UIColor redColor]];
        
        [self addSubview: self.navegadorWeb];
    }
    return self;
}

-(void)dealloc
{
    [self setControladorSencha:nil];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [[self controladorSencha] setVistaPrincipal: self];
    
    [[self navegadorWeb] setOpaque:NO];
    [[self navegadorWeb] setBackgroundColor:[UIColor clearColor]];
    
    [[self controladorSencha] setWebView: [self navegadorWeb]];
    [[self controladorSencha] viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction) accionarLeyendas:(id)sender {
    [[self navegadorWeb] performSelectorOnMainThread: @selector(stringByEvaluatingJavaScriptFromString:) 
                                          withObject:@"Ext.dispatch({ controller: 'ControladorGrafica', action: 'mostrarFiltroGrafica'});" waitUntilDone:false];
}

-(UIView *) obtenerRepresentacionBajoMarco:(CGRect) tamanioVentana
{
    return self;
}

-(UIView *) obtenerRepresentacion
{
    return self;
}

- (void)handleCall:(NSString*)functionName callbackId:(int)callbackId args:(NSArray*)args webView: (UIWebView *)webView andNativeBridge: (id<INativeBridge>) nativeBridge
{
    if([functionName isEqualToString: @"graficaActiva"])
        [[self etiquetaNombregrafica] setText:[args objectAtIndex:0]];
    
}

@end
