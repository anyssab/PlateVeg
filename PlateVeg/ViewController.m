//
//  ViewController.m
//  PlateVeg
//
//  Created by Anyssa Buchanan on 3/18/14.
//  Copyright (c) 2014 Anyssa Buchanan. All rights reserved.
//

#import "ViewController.h"
#import "PlistHandler.h"
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIView *dropTarget;
@property (nonatomic,strong)  UIImageView *dragObject;
@property (nonatomic, assign) CGPoint touchOffset;
@property (nonatomic, assign) CGPoint homePosition;
@property (nonatomic,strong) UIImageView *currentView;
@property (nonatomic, strong) NSArray *plateImages;

@property (nonatomic) UIView *plateOverlay;
@property (nonatomic) ServerQueue *serverQueue;


@end

@implementation ViewController



@synthesize dropTarget;
@synthesize dragObject;
@synthesize touchOffset;
@synthesize homePosition;
@synthesize plateOverlay;
@synthesize serverQueue;

- (void)viewDidLoad
{
    
    counter = 0;
    count.text = @"0";
    count1.text= @"0";
    count2.text=@"0";
    count3.text=@"0";
    count4.text=@"0";
    count5.text=@"0";
    count6.text=@"0";
    count7.text=@"0";
    
    
    [super viewDidLoad];
    
    Image0.image = [UIImage imageNamed:@"veg.png"];
    Image1.image = [UIImage imageNamed:@"fruit.png"];
    Image2.image = [UIImage imageNamed:@"bread.png"];
    Image3.image = [UIImage imageNamed:@"dairy.png"];
    Image4.image = [UIImage imageNamed:@"fat.png"];
    Image5.image = [UIImage imageNamed:@"oil.png"];
    Image6.image = [UIImage imageNamed:@"nuts.png"];
    Image7.image = [UIImage imageNamed:@"meat.png"];
    
    
    
    //image for plate
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Image8.frame.size.width, Image8.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"plate.png"];
    [Image8 addSubview:imageView];
    
    
    //overlay to change color when food comes in contact with plate
    plateOverlay = [[UIView alloc] initWithFrame:Image8.frame];
    [plateOverlay setBackgroundColor:[UIColor blueColor]];
    [plateOverlay setAlpha:0.6];
    [plateOverlay setHidden:YES];
    [self.view addSubview:plateOverlay];
    [plateOverlay.layer setZPosition:-1.5];
    
    //z position to make the duplicate image come from the front
    [Image8.layer setZPosition:-2];
    
    self.plateImages= @[Image0, Image1, Image2, Image3, Image4, Image5, Image6, Image7];
    
    
    for (UIImageView *imgView in self.plateImages) {
        UIImageView *imgCopy = [[UIImageView alloc] initWithFrame:imgView.frame];
        [imgCopy setImage:imgView.image];
        
        [self.view addSubview:imgCopy];
        [self.view sendSubviewToBack:imgCopy];
        [imgCopy.layer setZPosition:-2];
        
        
    }
    
    
    NSNumber *studyNumber = [NSNumber numberWithInteger:10098];
    NSString *password = [self sha1:@"text"];
    
    PlistHandler *handler = [[PlistHandler alloc]init];
    
    [handler saveStudyNumber:studyNumber];
    [handler savePassword:password];
    
    serverQueue = [[ServerQueue alloc] init];
    
    serverQueue.delegate = self;
    

    Inq *inq = [[Inq alloc] initGoal:@"GOAL" :[NSNumber numberWithInt:160] :[NSNumber numberWithFloat:67.5]:[NSNumber numberWithInt:30] :[NSNumber numberWithInt: 0] :[NSNumber numberWithInt: 120]];
    [serverQueue addToQueue: inq];
    
}

- (void)storeGoal: (Goal *) packet{
    
}


//http://www.makebetterthings.com/iphone/how-to-get-md5-and-sha1-in-objective-c-ios-sdk/
-(NSString*) sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return [output uppercaseString];
}


@synthesize Image0;
@synthesize Image1;
@synthesize Image2;
@synthesize Image3;
@synthesize Image4;
@synthesize Image5;
@synthesize Image6;
@synthesize Image7;
@synthesize Image8;



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    for (UIImageView *imageView in self.plateImages) {
        CGPoint locationInView = [imageView convertPoint:location fromView:imageView.window];
        if (CGRectContainsPoint(imageView.bounds, locationInView)) {
            self.currentView = imageView;
            [self.currentView.layer setZPosition:-1];
            break;
            // Point lies inside the bounds.
        }
    }
    
}

-(BOOL) didFoodTouchPlate: (UIImageView*) item{
    
    if (item == nil){
        return NO;
    }
    CGPoint locationTopLeft = CGPointMake(item.frame.origin.x, item.frame.origin.y);
    CGPoint locationTopRight = CGPointMake(item.frame.origin.x + item.frame.size.width , item.frame.origin.y);
    CGPoint locationBottomLeft = CGPointMake(item.frame.origin.x, item.frame.origin.y + item.frame.size.height);
    CGPoint locationBottomRight = CGPointMake(item.frame.origin.x + item.frame.size.width, item.frame.origin.y + item.frame.size.height);
    
    if ([self isWithinFrame:locationTopLeft plateFrame:self.dropTarget.frame]) {
        return YES;
    }
    if ([self isWithinFrame:locationTopRight plateFrame:self.dropTarget.frame]) {
        return YES;
    }
    if ([self isWithinFrame:locationBottomRight plateFrame:self.dropTarget.frame]) {
        return YES;
    }
    if ([self isWithinFrame:locationBottomLeft plateFrame:self.dropTarget.frame]) {
        return YES;
    }
    return NO;
}

-(BOOL) isWithinFrame: (CGPoint) location plateFrame: (CGRect) frame {
    if (location.x > frame.origin.x &&
        location.x < frame.origin.x + frame.size.width &&
        location.y > frame.origin.y &&
        location.y < frame.origin.y + frame.size.height) {
        return YES;
    } else {
        return NO;
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    if (self.currentView != nil ){
        self.currentView.center = location;
    }
    if ([self didFoodTouchPlate:self.currentView]){
        NSLog(@"you ate something");
        [plateOverlay setHidden:NO];
    } else {
        [plateOverlay setHidden:YES];
        
    }
    
    
}





- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [plateOverlay setHidden:YES];
    
    CGPoint location = [[touches anyObject] locationInView:self.view];
    
    if (location.x > self.dropTarget.frame.origin.x &&
        location.x < self.dropTarget.frame.origin.x + self.dropTarget.frame.size.width &&
        location.y > self.dropTarget.frame.origin.y &&
        location.y < self.dropTarget.frame.origin.y + self.dropTarget.frame.size.height )
        
        
    {
        
        //self.dropTarget.backgroundColor = self.dragObject.backgroundColor;
        
    }
    self.dragObject.frame = CGRectMake(self.homePosition.x, self.homePosition.y,
                                       self.dragObject.frame.size.width,
                                       self.dragObject.frame.size.height);
    
    
    
    [self.view addSubview:_currentView];
    [_currentView.layer setZPosition:-1];
    
    
    if([self didFoodTouchPlate: self.currentView]){
        if ([self.currentView isEqual:Image0]){
            int counter = [count.text integerValue];
            counter++;
            count.text=[NSString stringWithFormat:@"%i", counter];
        }else if([self.currentView isEqual:Image1]){
            int counter= [count1.text integerValue];
            counter++;
            count1.text=[NSString stringWithFormat:@"%i", counter];
        }
        else if([self.currentView isEqual:Image2]){
            int counter = [count2.text integerValue];
            counter++;
            count2.text = [NSString stringWithFormat:@"%i", counter];
        }
        else if([self.currentView isEqual:Image3]){
            int counter = [count3.text integerValue];
            counter++;
            count3.text = [NSString stringWithFormat:@"%i", counter];
        }
        else if([self.currentView isEqual:Image4]){
            int counter =[count4.text integerValue];
            counter++;
            count4.text = [NSString stringWithFormat:@"%i", counter];
        }
        else if([self.currentView isEqual:Image5]){
            int counter = [count5.text integerValue];
            counter++;
            count5.text = [NSString stringWithFormat:@"%i", counter];
        }
        else if ([self.currentView isEqual:Image6]){
            int counter = [count6.text integerValue];
            counter++;
            count6.text = [NSString stringWithFormat:@"%i", counter];
        }else{
            int counter = [count7.text integerValue];
            counter++;
            count7.text = [NSString stringWithFormat:@"%i", counter];
        }
    }
    
    
    
    self.currentView = nil;
    
    [super touchesEnded:touches withEvent:event];
    [self logTouchesFor:event];
}



-(void)logTouchesFor: (UIEvent*)event
{
    int count = 1;
    
    for (UITouch* touch in event.allTouches)
    {
        CGPoint location = [touch locationInView: self.view];
        
        NSLog(@"%d: (%.0f, %.0f)", count, location.x, location.y);
        count++;
    }
}

-(void) numbersMatch
{
    if (count == countD0) {
        NSLog(@"Congrats you ate your required veggies!");
    }
    else if(count1 == countD1){
        NSLog(@"Congrats you ate your required fruits");
    }
    if(count2 == countD2){
        NSLog(@"You ate your daily required carbs");
    }
    else if(count2 > countD2){
        NSLog(@"Stop eating carbs");
    }
    if(count3 == countD3){
        NSLog(@"You ate your required dairy");
    }
    else if(countD3 < count3){
        NSLog(@"Too much dairy");
    }
    if(count4 == countD4){
        NSLog(@"All done with sweets");
    }
    else if(countD4 < count4){
        NSLog(@"Stop eating sweets");
    }
    if(count5 == countD5){
        NSLog(@"you ate all your fats/oils");
    }
    else if(count5 > countD5){
        NSLog(@"Too much fats");
    }
    if(count6 == countD6){
        NSLog(@"You ate all your legumes today");
    }
    else if(count6 > countD6){
        NSLog(@"you exceeded your limit");
    }
    if (count7 == countD7) {
        NSLog(@"you ate all your meat today");
    }
    else if(count7 > countD7){
        NSLog(@"you exceeded your meat intake");
    }
}



- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
