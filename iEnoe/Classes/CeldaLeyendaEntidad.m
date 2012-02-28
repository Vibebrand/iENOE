//
//  CeldaLeyendaEntidad.m
//  iEnoe
//
//  Created by Jesus Cagide on 26/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "CeldaLeyendaEntidad.h"

@implementation CeldaLeyendaEntidad

@synthesize contenedorGraficaBarra;
@synthesize nombreEntidad;
@synthesize valorIndicador;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(void)agregarBarraAlaCelda
{
    _representacionGraficaBarra = [[PDColoredProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
    if( self.contenedorGraficaBarra )
    {
        
        CGRect _frame = [[self contenedorGraficaBarra] frame];
		_frame.origin.x = 0;
		_frame.origin.y = 0;
        [_representacionGraficaBarra setFrame:_frame];
        
        [[self contenedorGraficaBarra] insertSubview:_representacionGraficaBarra atIndex:0];
        
        [_representacionGraficaBarra setTintColor:[UIColor purpleColor]];
    }
}

-(void) dealloc
{
    self.contenedorGraficaBarra = nil;
    self.nombreEntidad = nil;
    self.valorIndicador = nil;
    [_representacionGraficaBarra release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

-(void)establecerNombreCelda:(NSString*)nombre conValor:(float) valor
{
    [self.nombreEntidad setText:nombre];
    [self.valorIndicador setText:[NSString stringWithFormat:@"%.2f", valor]];  
    [_representacionGraficaBarra setProgress:valor animated:TRUE];
}

@end
