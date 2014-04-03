/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "ISQuiz.h"
#import "ISSession.h"

static NSString * const _ISQuestionsKey = @"questions";
static NSString * const _ISTimeLimitKey = @"timeLimit";

@implementation ISGradingResult

@end


@implementation ISQuiz

+ (ISGradingResult*)gradeSession:(ISSession*)session quiz:(ISQuiz*)quiz
{
    int totalPoints = 0;
    int totalQuestions = (int)quiz.questions.count;
    
    int correctQuestions = 0;
    int correctPoints = 0;
    
    for (int i = 0; i < totalQuestions; i ++)
    {
        ISQuestion* question = (quiz.questions)[i];
        ISQuestionResponse* response = (session.responses)[i];
        
        BOOL correct = [question responseCorrect:response];
        
        if (correct)
        {
            correctQuestions++;
            correctPoints += question.scoreValue;
        }
        
        totalPoints += question.scoreValue;
    }
        
    ISGradingResult* result = [[ISGradingResult alloc] init];
    result.pointPercentage = (float)correctPoints / (float)totalPoints;
    result.points = correctPoints;
    result.pointsPossible = totalPoints;
    result.questionsCorrect = correctQuestions;
    result.questionsPossible = totalQuestions;
    result.questionPercentage = (float)correctQuestions / (float)totalQuestions;
    return result;
}

- (id)init
{
    if (self = [super init])
    {
        _questions = [[NSMutableArray alloc] init];
        self.timeLimit = -1.0;
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        _questions = [[NSMutableArray alloc] init];
        [_questions addObjectsFromArray:[decoder decodeObjectForKey:_ISQuestionsKey]];
        
        _timeLimit = [decoder decodeDoubleForKey:_ISTimeLimitKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_questions forKey:_ISQuestionsKey];
    [coder encodeDouble:_timeLimit forKey:_ISTimeLimitKey];
}

- (ISGradingResult*)gradeSession:(ISSession*)session
{
    return [ISQuiz gradeSession:session quiz:self];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@: %p, questions: %@>",
            NSStringFromClass([self class]), self, _questions];
}

- (void)addQuestion:(ISQuestion*)question
{
    [_questions addObject:question];
}

- (void)removeQuestion:(ISQuestion*)question
{
    [_questions removeObject:question];
}

- (void)removeAllQuestions
{
    [_questions removeAllObjects];
}


@end
