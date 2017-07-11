/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "MultipleChoiceViewController.h"

@interface MultipleChoiceViewController ()

- (void)scoreAndProgress;

@end

@implementation MultipleChoiceViewController

- (id)initWithMultipleChoiceQuestion:(ISMultipleChoiceQuestion*)question
                            response:(ISMultipleChoiceResponse*)response
                          controller:(id <QuizController>)controller
                       responceGiven:(ISQuestionResponseWasGiven)responceGiven
{
    if (self = [super initWithController:controller responceGivenBlock:responceGiven])
    {
        _question = question;
        _response = response;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _questionTextView.text = _question.text;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)next:(id)sender
{
    [self scoreAndProgress];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _question.options.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    ISMultipleChoiceOption* option = (_question.options)[row];
    return option.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scoreAndProgress {
    
    if(_response) {
        _response.answerIndex = (int)[_pickerView selectedRowInComponent:0];
    } else {
        _response = [ISMultipleChoiceResponse responseWithAnswerIndex:(int)[_pickerView selectedRowInComponent:0]];
    }
    
    [super scoreAndProgressWithResponse:_response];
}

@end
