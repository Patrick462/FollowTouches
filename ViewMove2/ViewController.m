//
//  ViewController.m
//  ViewMove2
//
//  Created by Patrick Weigel on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    arrayOfBoxes = [NSMutableArray new];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)addABox:(id)sender
{
    UIImageView *newBox = [UIImageView new];
    u_int32_t xRandom = arc4random_uniform(668);
    u_int32_t yRandom = 120 + arc4random_uniform(734);
    u_int32_t widthRandom = arc4random_uniform(20);
    u_int32_t heightRandom = arc4random_uniform(30);
    newBox.frame = CGRectMake(xRandom, yRandom, 90 + widthRandom, 135 + heightRandom);
    
    switch (arc4random_uniform(6))
    {
        case 0:
            newBox.image = [UIImage imageNamed:@"Linen Green 480x480.png"];
            break;
        case 1:
            newBox.image = [UIImage imageNamed:@"Linen Grey 480x480.png"];
            break;
        case 2:
            newBox.image = [UIImage imageNamed:@"bnr_hat_only.png"];
            break;
        case 3:
            newBox.image = [UIImage imageNamed:@"background.png"];
            break;
        case 4:
            newBox.image = [UIImage imageNamed:@"background copy.png"];
            break;
        case 5:
            newBox.image = [UIImage imageNamed:@"bomb.png"];
            break;
            
        default:
            newBox.backgroundColor = [UIColor blackColor];
            break;
    }

    [self.view addSubview:newBox];
    int arrayCount = [arrayOfBoxes count];
//    NSLog(@"ViewController/addABox Array Count: %d", arrayCount);
    [arrayOfBoxes insertObject:newBox atIndex:arrayCount];
    
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ViewController/touchesBegan");
    UITouch *thisTouch = [touches anyObject];
    CGPoint touchPoint = [thisTouch locationInView:self.view];
    for (UIView *view in arrayOfBoxes)
    {
        if (CGRectContainsPoint(view.frame, touchPoint))
        {
            currentViewBeingTouched = view;
//            NSLog(@"ViewController/touchesBegan CurrenView X:%6.1f Y:%6.1f  TouchPoint X:%6.1f, Y:%6.1f",
//                  currentViewBeingTouched.center.x,
//                  currentViewBeingTouched.center.y,
//                  touchPoint.x,
//                  touchPoint.y);
            offsetXCurrentPointFromViewCenter = currentViewBeingTouched.center.x - touchPoint.x;
            offsetYCurrentPointFromViewCenter = currentViewBeingTouched.center.y - touchPoint.y;
        }
    }
    
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint centerWithOffset;
    UITouch *thisTouch = [touches anyObject];
    currentPoint = [thisTouch locationInView:self.view];
    centerWithOffset = CGPointMake(currentPoint.x + offsetXCurrentPointFromViewCenter,
                                   currentPoint.y + offsetYCurrentPointFromViewCenter);
    currentViewBeingTouched.center = centerWithOffset;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint centerWithOffset;
    UITouch *thisTouch = [touches anyObject];
    currentPoint = [thisTouch locationInView:self.view];
    centerWithOffset = CGPointMake(currentPoint.x + offsetXCurrentPointFromViewCenter,
                                   currentPoint.y + offsetYCurrentPointFromViewCenter);
    currentViewBeingTouched.center = centerWithOffset;
    
    // brief pulse animation to let user know they have dropped the view
    // 1. Make it bigger, expand from center
    [UIImageView beginAnimations:nil context:nil];
    [UIImageView setAnimationDelegate:self];
    [UIImageView setAnimationDuration:0.5];
    [UIImageView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    float originX    = currentViewBeingTouched.frame.origin.x;
    float originY    = currentViewBeingTouched.frame.origin.y;
    float sizeWidth  = currentViewBeingTouched.frame.size.width;
    float sizeHeight = currentViewBeingTouched.frame.size.height;
    
    currentViewBeingTouched.frame = CGRectMake(originX - 0.5 * (0.1 * sizeWidth),
                                               originY - 0.5 * (0.1 * sizeHeight),
                                               1.1 * sizeWidth,
                                               1.1 * sizeHeight);
    // 2. return to original size and position
    [UIImageView commitAnimations];
    
    [UIImageView beginAnimations:nil context:nil];
    [UIImageView setAnimationDelegate:self];
    [UIImageView setAnimationDuration:0.5];
    [UIImageView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    currentViewBeingTouched.frame = CGRectMake(originX,
                                               originY,
                                               sizeWidth,
                                               sizeHeight);
    
    [UIImageView commitAnimations];

    currentViewBeingTouched = nil;
}

@end
