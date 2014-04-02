//
//  BaseQuestionViewController.m
//  QuizKitSample
//
//  Created by Christian French on 01/04/2014.
//  Copyright (c) 2014 Infuse Medical. All rights reserved.
//

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

@end
