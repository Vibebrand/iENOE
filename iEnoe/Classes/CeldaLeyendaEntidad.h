//
//  CeldaLeyendaEntidad.h
//  iEnoe
//
//  Created by Jesus Cagide on 26/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PDColoredProgressView.h"


@interface CeldaLeyendaEntidad : UITableViewCell
{
    
    PDColoredProgressView *_representacionGraficaBarra;
}


-(void)agregarBarraAlaCelda;
-(void)establecerNombreCelda:(NSString*)nombre conValor:(float) valor;

@property(nonatomic, assign) IBOutlet UILabel * nombreEntidad;
@property(nonatomic, assign) IBOutlet UILabel * valorIndicador;
@property(nonatomic, assign) IBOutlet UIView * contenedorGraficaBarra;

@end
