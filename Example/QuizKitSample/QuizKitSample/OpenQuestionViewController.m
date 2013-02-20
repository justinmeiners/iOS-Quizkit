/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "OpenQuestionViewController.h"

@interface OpenQuestionViewController ()

@end

@implementation OpenQuestionViewController

- (id)initWithOpenQuestion:(ISOpenQuestion*)question
                  response:(ISOpenQuestionResponse*)response
{
    if (self = [super initWithNibName:@"OpenQuestionViewController" bundle:NULL])
    {
        _questionTextView.text = question.text;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
