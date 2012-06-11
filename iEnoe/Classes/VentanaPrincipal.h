//
//  VentanaPrincipal.h
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iControladorVista.h"

@interface VentanaPrincipal : UIViewController

@property(nonatomic, retain)id<iControladorVista> controladorMapa;
@property(nonatomic, retain) id<iControladorVista> controladorGraficaArea;
@property(nonatomic, retain) id<iControladorVista> controladorLeyanda;
@property(nonatomic, retain) id<iControladorVista> controladorLineaTiempo;


@property(nonatomic, assign) IBOutlet UIView * representacionMapa;
@property(nonatomic, assign) IBOutlet UIView * representacionGraficaArea;
@property(nonatomic, assign) IBOutlet UIView * representacionLeyenda;
@property(nonatomic, assign) IBOutlet UIView * representacionLineaTiempo;



@end
