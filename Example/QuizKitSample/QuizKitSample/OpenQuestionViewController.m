/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "OpenQuestionViewController.h"

@interface OpenQuestionViewController ()

- (void)scoreAndProgress;

@end

@implementation OpenQuestionViewController

- (id)initWithOpenQuestion:(ISOpenQuestion*)question
                  response:(ISOpenQuestionResponse*)response
                controller:(id <QuizController>)controller
{
    if (self = [super initWithNibName:@"OpenQuestionViewController" bundle:NULL])
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
    _responseField.delegate = self;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [_responseField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self scoreAndProgress];
    return true;
}

- (void)next:(id)sender
{
    [self scoreAndProgress];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scoreAndProgress {
    
    [_controller nextQuestion];
}

@end
