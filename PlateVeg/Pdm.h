//
//  Pdm.h
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Packet.h"

@interface Pdm : Packet {
    @private
    NSNumber *totalSteps;
}

-(id) init: (NSNumber *) totalSteps_ : (NSString *) date_;
-(NSString *) toString;
-(NSString *) string;
-(NSNumber *) getTotalSteps;
-(void) setTotalSteps: (NSNumber *) totalSteps_;

-(NSDictionary *) getDictionary;
@end
