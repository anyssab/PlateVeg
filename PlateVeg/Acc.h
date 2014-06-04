//
//  Acc.h
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Packet.h"

@interface Acc : Packet {
    @private
    NSNumber *studyNumber;
    NSString *password;
}

-(id) init: (NSNumber *) studyNumber :(NSString *) password;


-(NSString *) toString;

//-(NSString *) string;
//
//-(NSNumber *) getStudyNumber;
//-(void) setStudyNumber:(NSNumber *)studyNumber;
//-(NSString *) getPassword;
//
//-(void) setPassword: (NSString *) password;
//-(NSDictionary *) getDictionary;

-(NSString *) getPassword;
-(NSNumber *) getStudyNumber;
@end
