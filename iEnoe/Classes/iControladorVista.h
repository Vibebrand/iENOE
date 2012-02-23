//
//  iControladorVista.h
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iControladorVista <NSObject>

-(UIView *) obtenerRepresentacionBajoMarco:(CGRect) tamanioVentana;
-(UIView *) obtenerRepresentacion;


@end
