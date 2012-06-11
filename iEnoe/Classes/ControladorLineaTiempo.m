//
//  ControladorLineaTiempo.m
//  iEnoe
//
//  Created by Jesus Cagide on 28/02/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "ControladorLineaTiempo.h"

@implementation ControladorLineaTiempo

-(void) dealloc
{
    [_tablaTrimestres release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tablaTrimestres = [[JMTabView alloc] initWithFrame:self.view.bounds];
    [_tablaTrimestres setDelegate:self];
    
    [_tablaTrimestres addTabItemWithTitle:@"Primero" icon:nil];
    [_tablaTrimestres addTabItemWithTitle:@"Segundo" icon:nil];
    [_tablaTrimestres addTabItemWithTitle:@"Tercero" icon:nil];
    [_tablaTrimestres addTabItemWithTitle:@"Cuarto" icon:nil];
    
    [[self view] insertSubview:_tablaTrimestres  atIndex:0];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark JMTabViewDelegate

-(void)tabView:(JMTabView *)tabView didSelectTabAtIndex:(NSUInteger)itemIndex
{
    NSString* repsuesta = [NSString stringWithFormat:@" numero precionado %d", itemIndex];
    NSLog(@"%@",repsuesta);
}

#pragma mark iControladorVista
-(UIView *) obtenerRepresentacionBajoMarco:(CGRect) tamanioVentana
{
    return [self view];
}
-(UIView *) obtenerRepresentacion
{
    return [self view];
}


@end
