//
//  OpenQuestionViewController.m
//  QuizKitSample
//
//  Created by Justin Meiners on 2/20/13.
//  Copyright (c) 2013 Infuse Medical. All rights reserved.
//

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
