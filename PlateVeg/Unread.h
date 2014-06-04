//
//  Unread.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 2/10/14.
//  Copyright (c) 2014 BU. All rights reserved.
//

#import "Packet.h"

@interface Unread : Packet{
    @private
    NSString *unreadType;
    NSMutableArray *unreadValue;
}

-(id) init: (NSString *) unreadType_ : (NSMutableArray *) unreadValue_;
-(id) init: (NSDictionary *) dict;

-(NSString *) unreadType;
-(NSMutableArray *) unreadValue;
-(void) setUnreadType:(NSString *)unreadType_;
-(void) setUnreadValue:(NSMutableArray *)unreadValue_;

@end
