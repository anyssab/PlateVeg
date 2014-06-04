//
//  Bcm.h
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Packet.h"

@interface Bcm : Packet {
    @private
    NSNumber *weight;
}

-(id) init: (NSNumber *) weight_ : (NSString *) date_;
-(NSString *) toString;
-(NSString *) string;

-(NSNumber *) getWeight;
-(void) setWeight:(NSNumber *) weight_;

-(NSDictionary *) getDictionary;
@end
