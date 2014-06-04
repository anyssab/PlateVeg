//
//  Ack.h
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Packet.h"

/** Op_code for ack packet */
typedef enum opcode {
    VALID,
    UPDATED,
    FAILED
} Opcode;

/** For failing reason */
typedef enum reason {
    NA,
    DUPLICATE_ENTRY,
    INVALID_STUDY_NUMBER,
    INCORRECTPASSWORD,
    OBJ_NULL,
    CONSTRAINT_FAILED
} Reason;

@interface Ack : Packet {
    @private
    NSString *opCode;
    NSString *reason;
//    Opcode opCode;
//	Reason reason;
}

-(id) init: (NSString *) op :(NSString *) r;
-(id) init: (NSDictionary *) dict;
-(NSString *) toString;
-(NSDictionary *) getDictionary;
-(NSString *) getOpCode;
-(NSString *) getReason;
@end
