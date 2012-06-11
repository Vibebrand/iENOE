//
//  Entidad.h
//  iEnoe
//
//  Created by Jesus Cagide on 26/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorLeyenda.h"
@interface Entidad : NSObject

@property(nonatomic, retain) NSString *nombre;
@property(nonatomic, retain) NSString *nombreRepresentacion;
@property(nonatomic, assign) ColorLeyenda* color;
@property(nonatomic, assign) float indicador;

@end
