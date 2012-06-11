//
//  CeldaLeyendaMapa.h
//  iEnoe
//
//  Created by Jesus Cagide on 22/05/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepresentacionCeldaLeyendaMapa.h"

@interface CeldaLeyendaMapa : UITableViewCell

@property(nonatomic, retain) RepresentacionCeldaLeyendaMapa* representacionCeldaLeyendaMapa;

- (void)redisplay;

@end
