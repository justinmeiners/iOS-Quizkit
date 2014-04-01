/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "MultipleChoiceViewController.h"

@interface MultipleChoiceViewController ()

@end

@implementation MultipleChoiceViewController

- (id)initWithMultipleChoiceQuestion:(ISMultipleChoiceQuestion*)question
                            response:(ISMultipleChoiceOption*)response
                          controller:(id <QuizController>)controller
{
    if (self = [super initWithNibName:@"MultipleChoiceViewController" bundle:NULL])
    {
        _question = question;
        _controller = controller;
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
    [_controller nextQuestion];
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

@end
