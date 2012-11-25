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
    UIView *newBox = [UIView new];
    newBox.frame = CGRectMake(334, 140, 100, 150);
    newBox.backgroundColor = [UIColor blueColor];
    [self.view addSubview:newBox];
    [arrayOfBoxes insertObject:newBox atIndex:0];
    
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
