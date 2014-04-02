/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <UIKit/UIKit.h>
#import "BaseQuestionViewController.h"

@interface OpenQuestionViewController : BaseQuestionViewController <UITextFieldDelegate>
{
    IBOutlet UITextView* _questionTextView;
    IBOutlet UITextField* _responseField;
    ISOpenQuestion* _question;
    ISOpenQuestionResponse* _response;
}

- (id)initWithOpenQuestion:(ISOpenQuestion*)question
                  response:(ISOpenQuestionResponse*)response
                controller:(id <QuizController>)controller
             responceGiven:(ISQuestionResponseWasGiven)responceGiven;

@end
