//
//  ControladorGraficaSencha.m
//  iGlobo
//
//  Created by Jesus Cagide on 14/12/11.
//  Copyright (c) 2011 INEGI. All rights reserved.
//

#import "ControladorGraficaSencha.h"
#import "NativeBridge.h"

@implementation ControladorGraficaSencha

@synthesize  etiquetaNombregrafica;
@synthesize navegadorWeb;
@synthesize controladorSencha;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil yControladorSencha:(ControladorSencha *) controladorSenchaEntrada {
    
    if([self initWithNibName:nibNameOrNil bundle: nibBundleOrNil]) {
        [self setControladorSencha: controladorSenchaEntrada];
        [controladorSencha setVistaPrincipal:[self view]];
    }
    return self;
}

-(void)dealloc
{
    [self setControladorSencha:nil];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navegadorWeb] setOpaque:NO];
    [[self navegadorWeb] setBackgroundColor:[UIColor clearColor]];
    
    [[self controladorSencha] setWebView: [self navegadorWeb]];
    [[self controladorSencha] viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

-(IBAction) accionarLeyendas:(id)sender {
    [[self navegadorWeb] performSelectorOnMainThread: @selector(stringByEvaluatingJavaScriptFromString:) 
                                          withObject:@"Ext.dispatch({ controller: 'ControladorGrafica', action: 'mostrarFiltroGrafica'});" waitUntilDone:false];
}

-(UIView *) obtenerRepresentacionBajoMarco:(CGRect) tamanioVentana
{
    return [self view];
    
}
-(UIView *) obtenerRepresentacion
{
    return [self view];
}

- (BOOL) handleCall:(NSString*)functionName callbackId:(int)callbackId args:(NSArray*)args webView: (UIWebView *)webView andNativeBridge: (id<INativeBridge>) nativeBridge
{
    if([functionName isEqualToString: @"graficaActiva"]) {
        [[self etiquetaNombregrafica] setText:[args objectAtIndex:0]];
        return YES;
    }
    
    return NO;
}

@end
