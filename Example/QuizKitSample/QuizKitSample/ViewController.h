/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import <UIKit/UIKit.h>
#import "ISQuizKit.h"

@interface ViewController : UIViewController
{
    ISSession* _session;
}

- (IBAction)startQuiz:(id)sender;
@end
