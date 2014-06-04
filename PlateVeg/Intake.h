//
//  Intake.h
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Packet.h"

@interface Intake : Packet {
    /** &&& Intake readings &&& */
    @private
//    NSNumber *type1;
//    NSNumber *type2;
//    NSNumber *type3;
//    NSNumber *type4;
//    NSNumber *type5;
//    NSNumber *type6;
//    NSNumber *type7;
//    NSNumber *type8;
    NSNumber *dairy;
    NSNumber *fruit;
    NSNumber *grain;
    NSNumber *legume;
    NSNumber *meat;
    NSNumber *oil;
    NSNumber *sweet;
    NSNumber *vegetable;
    /** &&& EOF Intake readings &&& */
}
-(id) init: (NSNumber *) type1_ : (NSNumber *) type2_ : (NSNumber *) type3_ : (NSNumber *) type4_ : (NSNumber *) type5_ : (NSNumber *) type6_ : (NSNumber *) type7_ : (NSNumber *) type8_ : (NSString *) date_;
-(id) init: (NSDictionary *) dict;
-(NSString *) toString;
-(NSString *) string;

-(NSArray *) toArray;
-(NSNumber *) getDairy;
-(void) setDairy:(NSNumber *)dairy_;
-(NSNumber *) getFruit;
-(void) setFruit:(NSNumber *)fruit_;
-(NSNumber *) getGrain;
-(void) setGrain:(NSNumber *)grain_;
-(NSNumber *) getLegume;
-(void) setLegume:(NSNumber *)legume_;
-(NSNumber *) getMeat;
-(void) setMeat:(NSNumber *)meat_;
-(NSNumber *) getOil;
-(void) setOil:(NSNumber *)oil_;
-(NSNumber *) getSweet;
-(void) setSweet:(NSNumber *)sweet_;
-(NSNumber *) getVegetable;
-(void) setVegetable:(NSNumber *)vegetable_;
-(NSDictionary *) getDictionary;
@end
