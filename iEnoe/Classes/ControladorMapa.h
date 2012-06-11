//
//  ControladorMapa.h
//  iEnoe
//
//  Created by Jesus Cagide on 22/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//
#import "cocos2d.h"
#import <UIKit/UIKit.h>

#import "iEnoeLayer.h"
#import "iEnoeWorld.h"
#import "CC3EAGLView.h"

#import "iControladorVista.h"


@interface ControladorMapa : UIViewController<iControladorVista,UITableViewDelegate, UITableViewDataSource>
{
    EAGLView *_glView;
}




@property(nonatomic, assign) CCDirector* director;
@property(nonatomic, assign) IBOutlet UITableView* tablaLeyenda;

#pragma mark iControladorVista
-(UIView *) obtenerRepresentacionBajoMarco:(CGRect) tamanioVentana;
-(UIView *) obtenerRepresentacion;

@end
