//
//  ProgressData.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 7/18/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Packet.h"

@interface ProgressData : Packet {
    @private
    
    NSString *dataType; // Type of Data returning
	/** &&& EOF Progress Data &&& */
    
	// OPTIONAL for weight OR steps
	NSArray *data;
	NSArray *goal;
	// EOF OPTIONAL
    
	// OPTIONAL for BP OR Intake
	NSArray *data2;
	NSArray *goal2;

}

@property (nonatomic) NSArray *data;
@property (nonatomic) NSArray *goal;
@property (nonatomic) NSArray *data2;
@property (nonatomic) NSArray *goal2;

-(id) init: (NSArray *)data_ : (NSArray *)goal_;
-(id) init: (NSArray *)data_ : (NSArray *)data2_ : (NSArray *)goal_ : (NSArray *)goal2_;
-(id) init: (NSDictionary *) dict;
-(NSString *) toString;

@end
