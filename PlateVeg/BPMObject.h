//
//  BPMObject.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 7/30/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bpm.h"
@interface BPMObject : NSObject
@property (nonatomic) Bpm *value;
@property (nonatomic) NSDate *date;
@property (nonatomic) BOOL sent;


-(id) init;
-(id) initWithData: (Bpm*) value_ : (NSDate *) date_;
@end
