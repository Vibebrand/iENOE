//
//  ControlMaestro.m
//  iGlobo
//
//  Created by Jesus Cagide on 05/12/11.
//  Copyright (c) 2011 INEGI. All rights reserved.
//

#import "ControlMaestro.h"
#include "MotorIMapa.h"


@implementation ControlMaestro

- (id)init {
    self = [super init];
    if (self) {
        motor = new MotorIMapa;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(notificacionEstableceVariable:) name:@"estableceVariable" object: nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    delete motor;
    
    for(std::set<GestorCpp *>::iterator it_gestores = gestores.begin(); 
        it_gestores != gestores.end(); ++it_gestores) {
        delete *it_gestores;
    }
    gestores.clear();
    
    for(std::set<MotorIMapaAPI::IGestorSecciones *>::iterator it_gestores = gestoresCpp.begin(); 
        it_gestores != gestoresCpp.end(); ++it_gestores) {
        delete *it_gestores;
    }
    gestoresCpp.clear();
    
    [super dealloc];
}

- (void) registraGestor: (id<iGestorObjectiveC>) gestor {
    GestorCpp * gestorCppInteres = new GestorCpp(gestor, self);
    gestores.insert(gestorCppInteres);
    motor->registraGestorSecciones(gestorCppInteres);
}

- (void) registraGestorCpp: (MotorIMapaAPI::IGestorSecciones *) gestorSecciones {
    gestoresCpp.insert(gestorSecciones);
    motor->registraGestorSecciones(gestorSecciones);
}

- (void) estableceVariable:(NSString *) nombre valor: (NSString *) valor {
    const char * nombreInteres = [nombre UTF8String];
    const char * valorInteres = [valor UTF8String];
    
    motor->estableceCambioVariable(nombreInteres, valorInteres);
}

- (void) actualizaSecciones {
    motor->actualizaSecciones();
}

- (void) cargaArchivos {
    NSString * pathInteres = [[NSBundle mainBundle] bundlePath];
    NSArray * elementos = [NSBundle pathsForResourcesOfType: @"xml" inDirectory: pathInteres];
    NSEnumerator * it_elementos = [elementos objectEnumerator];
    id elemento = nil;
    while((elemento = [it_elementos nextObject])) {
        motor->procesaArchivo([elemento fileSystemRepresentation]);
    }
    
    [self performSelector:@selector(ejecutaEntidad:) withObject: nil afterDelay:5];
}

- (void) ejecutaEntidad: (id) objeto {
    [self estableceVariable:@"Entidad federativa" valor:@"Aguascalientes"];
    [self estableceVariable:@"Pais" valor:@"Mexico"];
    [self estableceVariable:@"Fecha" valor:@"2010"];
    
    [self actualizaSecciones];
}

- (void) notificacionEstableceVariable: (NSNotification *) notification {
    NSString * llave = [[notification userInfo] objectForKey: @"llave"];
    NSString * valor = [[notification userInfo] objectForKey: @"valor"];
    id actualizar = [[notification userInfo] objectForKey: @"actualizar"];
    
    if(valor && [llave length]) {
        [self estableceVariable: llave valor: valor];
    }
    
    if ([actualizar boolValue]) {
        [self actualizaSecciones];
    }
}

@end
