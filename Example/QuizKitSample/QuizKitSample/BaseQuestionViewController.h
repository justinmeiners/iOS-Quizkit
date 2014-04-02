/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <UIKit/UIKit.h>
#import "ISQuizKit.h"
#import "QuizController.h"

typedef void(^ISQuestionResponseWasGiven)(ISQuestionResponse* response);

@interface BaseQuestionViewController : UIViewController

@property(nonatomic, copy) ISQuestionResponseWasGiven questionResponseWasGiven;

@property(nonatomic, strong) id <QuizController> controller;

-(id)initWithController:(id <QuizController>)controller responceGivenBlock:(ISQuestionResponseWasGiven)responceGiven;

@end
