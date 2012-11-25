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
            newBox.image = [UIImage imageNamed:@"Linen Grey diagonal 100x150.png"];
            break;
        case 1:
            newBox.image = [UIImage imageNamed:@"Linen red diagonal 100x150.png"];
            break;
        case 2:
            newBox.image = [UIImage imageNamed:@"bnr_hat_only.png"];
            break;
        case 3:
            newBox.image = [UIImage imageNamed:@"background.png"];
            break;
        case 4:
            newBox.image = [UIImage imageNamed:@"Linen Green 480x480.png"];
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
    currentViewBeingTouched = nil;
}

@end
