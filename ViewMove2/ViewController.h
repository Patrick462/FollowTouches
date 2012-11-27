//
//  ViewController.h
//  ViewMove2
//
//  Created by Patrick Weigel on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    CGPoint currentPoint;
    float   offsetXCurrentPointFromViewCenter;
    float   offsetYCurrentPointFromViewCenter;
    float   originX;
    float   originY;
    float   sizeWidth;
    float   sizeHeight;
    BOOL    shouldCallDropCurrentView;
    BOOL    hasPulseBiggerFinished;
    BOOL    didTouchAView;

    
    NSMutableArray *arrayOfBoxes;
    UIView *currentViewBeingTouched;
}

-(IBAction)addABox:(id)sender;

@end
