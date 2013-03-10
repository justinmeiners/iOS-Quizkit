/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <UIKit/UIKit.h>
#import "ISQuizKit.h"
#import "QuizController.h"

@interface OpenQuestionViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextView* _questionTextView;
    IBOutlet UITextField* _responseField;
    ISOpenQuestion* _question;
    id <QuizController> _controller;
}

- (id)initWithOpenQuestion:(ISOpenQuestion*)question
                  response:(ISOpenQuestionResponse*)response
                controller:(id <QuizController>)controller;

@end
