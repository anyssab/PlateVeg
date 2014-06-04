//
//  IOSEnrollment.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/21/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Packet.h"

@interface IOSEnrollment : Packet <NSCoding> {
    @private
    NSString *device_id;
}
-(id) initWithDict: (NSDictionary *) dict;
-(id) init: (NSString *) device_id_;
@end
