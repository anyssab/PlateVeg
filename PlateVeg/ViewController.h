//
//  ViewController.h
//  PlateVeg
//
//  Created by Anyssa Buchanan on 3/18/14.
//  Copyright (c) 2014 Anyssa Buchanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.m"
#import "ServerQueue.h"


int counter;



@interface ViewController : UIViewController <ServerQueueDelegate> {

    //count is count0 label
    IBOutlet UILabel*count;
    IBOutlet UILabel*count1;
    IBOutlet UILabel*count2;
    IBOutlet UILabel*count3;
    IBOutlet UILabel*count4;
    IBOutlet UILabel*count5;
    IBOutlet UILabel*count6;
    IBOutlet UILabel*count7;
    
    IBOutlet UILabel *countD0;
    IBOutlet UILabel *countD1;
    IBOutlet UILabel *countD2;
    IBOutlet UILabel *countD3;
    IBOutlet UILabel *countD4;
    IBOutlet UILabel *countD5;
    IBOutlet UILabel *countD6;
    IBOutlet UILabel *countD7;

}

//-(IBAction)plus;
//-(IBAction)minus;


@property (strong, nonatomic) IBOutlet UIImageView *Image0;
@property (strong, nonatomic) IBOutlet UIImageView *Image1;
@property (strong, nonatomic) IBOutlet UIImageView *Image2;
@property (strong, nonatomic) IBOutlet UIImageView *Image3;
@property (strong, nonatomic) IBOutlet UIImageView *Image4;
@property (strong, nonatomic) IBOutlet UIImageView *Image5;
@property (strong, nonatomic) IBOutlet UIImageView *Image6;
@property (strong, nonatomic) IBOutlet UIImageView *Image7;


//this is the plate image
@property (strong, nonatomic) IBOutlet UIView *Image8;





@end
