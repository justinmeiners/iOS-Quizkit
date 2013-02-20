/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <UIKit/UIKit.h>
#import "ISQuizKit.h"

@interface OpenQuestionViewController : UIViewController
{
    IBOutlet UITextView* _questionTextView;
    IBOutlet UITextField* _responseField;
}

- (id)initWithOpenQuestion:(ISOpenQuestion*)question
                  response:(ISOpenQuestionResponse*)response;

@end
