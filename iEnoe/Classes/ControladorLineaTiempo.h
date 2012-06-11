//
//  ControladorLineaTiempo.h
//  iEnoe
//
//  Created by Jesus Cagide on 28/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iControladorVista.h"
#import "JMTabView.h"

@interface ControladorLineaTiempo : UIViewController<iControladorVista, JMTabViewDelegate>
{

    JMTabView * _tablaTrimestres; 
}


#pragma mark JMTabViewDelegate

-(void)tabView:(JMTabView *)tabView didSelectTabAtIndex:(NSUInteger)itemIndex;

#pragma mark iControladorVista
-(UIView *) obtenerRepresentacionBajoMarco:(CGRect) tamanioVentana;
-(UIView *) obtenerRepresentacion;


@end
