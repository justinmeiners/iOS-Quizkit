/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
#import "TrueFalseViewController.h"

@interface TrueFalseViewController ()

@end

@implementation TrueFalseViewController

- (id)initWithTrueFalseQuestion:(ISTrueFalseQuestion*)question
                       response:(ISTrueFalseResponse*)response
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
    [self.controller nextQuestion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
