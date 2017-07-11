/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "BaseQuestionViewController.h"

@interface BaseQuestionViewController ()

@end

@implementation BaseQuestionViewController

-(id)initWithController:(id <QuizController>)controller responceGivenBlock:(ISQuestionResponseWasGiven)responceGiven{
    
    if (self == [super init]) {
        _controller = controller;
        _questionResponseWasGiven = responceGiven;
    }
    
    return self;
}

- (void)scoreAndProgressWithResponse:(ISQuestionResponse*)response {
    
    if(_questionResponseWasGiven) {
        _questionResponseWasGiven(response);
    }
    
    [_controller nextQuestion];
}

@end
