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
@synthesize pointPercentage = _pointPercentage;
@synthesize pointsPossible = _pointsPossible;
@synthesize points = _points;
@synthesize questionsCorrect = _questionsCorrect;
@synthesize questionsPossible = _questionsPossible;
@synthesize questionPercentage = _questionPercentage;
@end


@implementation ISQuiz
@synthesize questions = _questions;
@synthesize timeLimit = _timeLimit;

+ (ISGradingResult*)gradeSession:(ISSession*)session quiz:(ISQuiz*)quiz
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
        
    ISGradingResult* result = [[ISGradingResult alloc] init];
    result.pointPercentage = (float)correctPoints / (float)totalPoints;
    result.points = correctPoints;
    result.pointsPossible = totalPoints;
    result.questionsCorrect = correctQuestions;
    result.questionsPossible = totalQuestions;
    result.questionPercentage = (float)correctQuestions / (float)totalQuestions;
    return [result autorelease];
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

- (void)dealloc
{
    [_questions release];
    [super dealloc];
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
