//
//  ControladorLeyenda.m
//  iEnoe
//
//  Created by Jesus Cagide on 26/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "ControladorLeyenda.h"
#import "Entidad.h"

@implementation ControladorLeyenda

@synthesize tablaDatos;
@synthesize celdaBarras;
@synthesize cellNib =_cellNib;
@synthesize entidades;


-(void)dealloc
{
    self.tablaDatos = nil;
    self.celdaBarras = nil;
    self.entidades= nil;
    
    [_cellNib release];
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
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.cellNib = [UINib nibWithNibName:@"CeldaLeyenda" bundle:nil];
    
    Entidad* entidad1 = [Entidad new];
    [entidad1 setNombre:@"Aguascalientes"];
    
    Entidad* entidad2 = [Entidad new];
    [entidad2 setNombre:@"Jalisco"];
    
    Entidad* entidad3 = [Entidad new];
    [entidad3 setNombre:@"Nayarit"];
    
    self.entidades =[[NSArray alloc] initWithObjects:entidad1,entidad2,entidad3, nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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


#pragma mark -
#pragma mark Table view datasource methods


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if(self.entidades)
        return [self.entidades count];
    return  0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identificador = @"Entidades";
    CeldaLeyendaEntidad *celda;
    celda = (CeldaLeyendaEntidad *)[tableView dequeueReusableCellWithIdentifier:identificador];
    
    if (celda == nil) {
        [self.cellNib  instantiateWithOwner:self options:nil];
        celda = [self celdaBarras];
        [celda agregarBarraAlaCelda];
        self.celdaBarras = nil;
    }
    
    if(entidades)
    {
        Entidad *entidad = [entidades  objectAtIndex: [indexPath row]  ];
        [celda establecerNombreCelda: [entidad nombre] conValor: 1.0f];
    }
    return celda;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 57;
}

#pragma mark -
#pragma mark Table view delegate methods

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"";
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
