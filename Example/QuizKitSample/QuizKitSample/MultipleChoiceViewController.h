/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <UIKit/UIKit.h>
#import "ISQuizKit.h"
#import "QuizController.h"
#import "BaseQuestionViewController.h"

@interface MultipleChoiceViewController : BaseQuestionViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UITextView* _questionTextView;
    IBOutlet UIPickerView* _pickerView;
    ISMultipleChoiceQuestion* _question;
    ISMultipleChoiceResponse* _response;
}

- (id)initWithMultipleChoiceQuestion:(ISMultipleChoiceQuestion*)question
                            response:(ISMultipleChoiceOption*)response
                          controller:(id <QuizController>)controller
                       responceGiven:(ISQuestionResponseWasGiven)responceGiven;

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

@end
