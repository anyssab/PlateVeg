//
//  Unread.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 2/10/14.
//  Copyright (c) 2014 BU. All rights reserved.
//

#import "Unread.h"

@interface Unread ()
@property (nonatomic) NSString *unreadType;
@property (nonatomic) NSMutableArray *unreadValue;
@end
@implementation Unread

-(id) init: (NSString *) unreadType_ : (NSMutableArray *) unreadValue_ {
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"UNREAD"];
        unreadType = unreadType_;
        unreadValue = unreadValue_;
    }
    return self;
}
-(id) init: (NSDictionary *) dict {
    if (self = [super init]) {
        [super setTypeOfPacket:@"TailoredGoal"];
        unreadType = [dict objectForKey:@"unreadType"];
        unreadValue = [dict objectForKey:@"unreadValue"];
    }
    return self;
}
-(NSString *) unreadType {
    return unreadType;
}

-(NSMutableArray *) unreadValue {
    return unreadValue;
}

-(void) setUnreadType:(NSString *)unreadType_ {
    unreadType = unreadType_;
}

-(void) setUnreadValue:(NSMutableArray *)unreadValue_ {
    unreadValue = unreadValue_;
}
@end
