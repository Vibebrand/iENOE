//
//  VentanaPrincipal.m
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "VentanaPrincipal.h"
#import "ControladorGraficaSencha.h"

@implementation VentanaPrincipal

@synthesize representacionMapa;
@synthesize controladorMapa;
@synthesize representacionGraficaArea;
@synthesize controladorGraficaArea;

-(void)dealloc
{
    self.representacionMapa = nil;
    self.controladorMapa = nil;
    self.representacionGraficaArea = nil;
    self.controladorGraficaArea = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.representacionGraficaArea = nil;
        self.controladorGraficaArea = nil;
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
    
    if([self controladorMapa])
        [[self representacionMapa] addSubview:[[self controladorMapa] obtenerRepresentacion]];
     
    
    if([self controladorGraficaArea]) {
        [[self representacionGraficaArea] addSubview:[[self controladorGraficaArea] obtenerRepresentacion]];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;;
}

@end
