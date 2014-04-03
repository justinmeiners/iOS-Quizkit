/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
#import "ISSession.h"

static NSString * const _ISUserDataKey = @"userData";
static NSString * const _ISResponsesKey = @"responses";
static NSString * const _ISTimeKey = @"time";
static NSString * const _ISBonusTimeKey = @"bonusTime";

@implementation ISSession

+ (ISSession*)session
{
    return [[self alloc] init];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        _responses = [[NSMutableArray alloc] init];
        [_responses addObjectsFromArray:[aDecoder decodeObjectForKey:_ISResponsesKey]];
        self.userData = [aDecoder decodeObjectForKey:_ISUserDataKey];
        _time = [aDecoder decodeDoubleForKey:_ISTimeKey];
        self.bonusTime = [aDecoder decodeDoubleForKey:_ISBonusTimeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_responses forKey:_ISResponsesKey];
    [aCoder encodeObject:_userData forKey:_ISUserDataKey];
    [aCoder encodeDouble:_time forKey:_ISTimeKey];
    [aCoder encodeDouble:_bonusTime forKey:_ISBonusTimeKey];
}

- (id)init
{
    if (self = [super init])
    {
        _bonusTime = 0.0;
        _time = 0.0;
        _responses = [[NSMutableArray alloc] init];
    }
    return self;
}


- (BOOL)start:(ISQuiz*)quiz
{
    if (_inSession)
    {
        NSLog(@"session already in session with quiz: %@", quiz);
        return NO;
    }
    
    _currentQuiz = quiz;
    
    if (_responses.count == 0)
    {
        for (int i = 0; i < _currentQuiz.questions.count; i ++)
        {
            ISEmptyQuestionResponse* emptyResponse = [[ISEmptyQuestionResponse alloc] init];
            [_responses addObject:emptyResponse];
        }
        
        _time = 0.0;
    }
    else
    {
        if (_responses.count != quiz.questions.count)
        {
            NSLog(@"resuming session with incorrect quiz");
            return NO;
        }
    }
    
    _sessionTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(tick:)
                                                   userInfo:nil repeats:YES];
    
    _startDate = [NSDate date];    

    _inSession = true;
    
    if (_delegate && [_delegate respondsToSelector:@selector(sessionStarted:)])
    {
        [_delegate sessionStarted:self];
    }
    
    return YES;
}

- (void)tick:(NSTimer*)timer
{
    _time = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    if (_currentQuiz.timeLimit > 0.0)
    {
        if (_time > _currentQuiz.timeLimit + _bonusTime)
        {
            if (_delegate && [_delegate respondsToSelector:@selector(sessionShouldStopAtTimeLimit:)])
            {
                if ([_delegate sessionShouldStopAtTimeLimit:self])
                {
                    [self stop];
                }
            }
            else
            {
                [self stop];
            }
        }
    }
}


- (void)stop
{
    if (!_inSession)
    {
        NSLog(@"ISSession finish when not in session");
        return;
    }
    
    [_sessionTimer invalidate];
    _sessionTimer = NULL;
        
    _time = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _inSession = false;
    
    _currentQuiz = NULL;
    
    if (_delegate && [_delegate respondsToSelector:@selector(sessionStopped:)])
    {
        [_delegate sessionStopped:self];
    }
}

- (void)setResponse:(ISQuestionResponse*)response
            atIndex:(int)index
{
    _responses[index] = response;
}

- (void)clearResponseAtIndex:(int)index
{
    _responses[index] = [ISEmptyQuestionResponse emptyResponse];
}

- (NSTimeInterval)time
{
    return _time;
}

@end
