/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import "ISGrader.h"

@implementation ISGrader

- (void)gradeSession:(ISSession*)session quiz:(ISQuiz*)quiz
{
    int totalPoints = 0;
    int totalQuestions = quiz.questions.count;
    
    int correctQuestions = 0;
    int correctPoints = 0;
    
    for (int i = 0; i < totalQuestions; i ++)
    {
        ISQuestion* question = [quiz.questions objectAtIndex:i];
        ISQuestionResponse* response = [session.responses objectAtIndex:i];
        
        BOOL correct = [question responseCorrect:response];
        
        if (correct)
        {
            correctQuestions++;
            correctPoints += question.scoreValue;
        }
        
        totalPoints += question.scoreValue;
    }
    
    float percentage = (float)correctPoints / (float)totalPoints;
    
    NSLog(@"%f", percentage);
}

@end
