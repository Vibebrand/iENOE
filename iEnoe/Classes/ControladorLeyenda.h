//
//  ControladorLeyenda.h
//  iEnoe
//
//  Created by Jesus Cagide on 26/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iControladorVista.h"
#import "CeldaLeyendaEntidad.h"

@interface ControladorLeyenda : UIViewController<UITableViewDelegate, UITableViewDataSource, iControladorVista>
{

    UINib *_cellNib;
}

#pragma mark iControladorVista
-(UIView *) obtenerRepresentacionBajoMarco:(CGRect) tamanioVentana;
-(UIView *) obtenerRepresentacion;

@property(nonatomic, assign) IBOutlet UITableView *tablaDatos;
@property(nonatomic, retain) IBOutlet CeldaLeyendaEntidad * celdaBarras;
@property(nonatomic, retain) UINib * cellNib;

@property(nonatomic, retain) NSArray* entidades;

@end
