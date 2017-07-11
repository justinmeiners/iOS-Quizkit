/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import "ViewController.h"
#import "OpenQuestionViewController.h"
#import "TrueFalseViewController.h"
#import "MultipleChoiceViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.delegate = self;
    _scoreLabel.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startQuiz:(id)sender
{
    _quiz = [ISQuizParser quizNamed:@"programming.plist"];
    
    _scoreLabel.text = @"";
    
    _session = [[ISSession alloc] init];
    [_session start:_quiz];
    
    _questionIndex = 0;
    [self nextQuestion];
}

- (ISSession*)session
{
    return _session;
} 

- (void)nextQuestion
{
    if (_questionIndex >= _quiz.questions.count)
    {
        [_session stop];
        
        ISGradingResult* result = [ISQuiz gradeSession:_session quiz:_quiz];
        
        
        _scoreLabel.text = [NSString stringWithFormat:@"Score %i/%i, Time: %.1fs,", result.points, result.pointsPossible, _session.time];
        [self.navigationController popToRootViewControllerAnimated:true];
        return;
    }
    
    ISQuestion* question = (_quiz.questions)[_questionIndex];
    
    int questionIndex = _questionIndex;
    
    if ([question isKindOfClass:[ISOpenQuestion class]])
    {
       
        OpenQuestionViewController* controller = [[OpenQuestionViewController alloc] initWithOpenQuestion:(ISOpenQuestion*)question
                                                                                                 response:nil
                                                                                               controller:self
                                                                                            responceGiven:^(ISQuestionResponse *response) {
            [_session setResponse:response atIndex:questionIndex];
        }];
                                                  
        [self.navigationController pushViewController:controller animated:true];
    }
    else if ([question isKindOfClass:[ISMultipleChoiceQuestion class]])
    {
        MultipleChoiceViewController* controller = [[MultipleChoiceViewController alloc] initWithMultipleChoiceQuestion:(ISMultipleChoiceQuestion*)question
                                                                                                               response:NULL
                                                                                                             controller:self
                                                                                                          responceGiven:^(ISQuestionResponse *response) {
                                                                                                                 [_session setResponse:response atIndex:questionIndex];
                                                                                                             }];
        [self.navigationController pushViewController:controller animated:true];
    }
    else if ([question isKindOfClass:[ISTrueFalseQuestion class]])
    {
        TrueFalseViewController* controller = [[TrueFalseViewController alloc] initWithTrueFalseQuestion:(ISTrueFalseQuestion*)question
                                                                                                response:NULL
                                                                                              controller:self
                                                                                           responceGiven:^(ISQuestionResponse *response) {
                                                                                                  [_session setResponse:response atIndex:questionIndex];
                                                                                              }];
        [self.navigationController pushViewController:controller animated:true];
    }
    
    _questionIndex += 1;
}

@end
