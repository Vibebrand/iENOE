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




@property(nonatomic, assign) IBOutlet UIView * representacionMapa;


@end
