/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import <UIKit/UIKit.h>
#import "ISQuizKit.h"
#import "QuizController.h"

@interface ViewController : UIViewController <QuizController, UINavigationControllerDelegate>
{
    IBOutlet UILabel* _scoreLabel;
    ISSession* _session;
    int _questionIndex;
    ISQuiz* _quiz;
}

- (IBAction)startQuiz:(id)sender;
- (void)nextQuestion;
@end
