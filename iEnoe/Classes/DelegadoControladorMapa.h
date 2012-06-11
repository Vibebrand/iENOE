//
//  DelegadoControladorMapa.h
//  iEnoe
//
//  Created by Jesus Cagide on 23/05/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DelegadoControladorMapa <NSObject>

-(void)cmdEstadoSelecionado(NSString*)nombreDelEstado;

@end
