//
//  MsgObject.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/28/13.
//  Copyright (c) 2013 BU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Msg.h"
#import "Packet.h"
@interface MsgObject : Packet<NSCoding>
@property (nonatomic) Msg *value;
@property (nonatomic) NSNumber *sent;
@property (nonatomic) NSNumber *msgIndex;

-(id) init;
-(id) initWithData: (Msg *) value_ : (NSNumber *) sent_ : (NSNumber *) msgIndex;
@end