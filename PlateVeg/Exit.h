//
//  Exit.h
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Packet.h"

@interface Exit : Packet {
    @private
    NSNumber *returnVal;
}

-(id) init;
-(NSString *) toString;

@end
