/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>
#import "ISQuiz.h"

@class ISSession;

@protocol ISSessionDelegate <NSObject>

@optional
- (void)sessionStarted:(ISSession*)session;
- (void)sessionStopped:(ISSession*)session;

- (void)sessionPaused:(ISSession*)session;
- (void)sessionResumed:(ISSession*)session;

- (BOOL)sessionShouldStopAtTimeLimit:(ISSession*)session;

@end

@interface ISSession : NSObject <NSCoding>
{
    NSDate* _startDate;
    NSMutableArray* _responses;
    NSTimeInterval _time;
    NSTimeInterval _bonusTime;
    NSTimer* _sessionTimer;
    ISQuiz* _currentQuiz;
}
@property(nonatomic, readonly)NSArray* responses;
@property(nonatomic, retain)NSDictionary* userData;
@property(nonatomic, readonly)BOOL inSession;
@property(nonatomic, assign)id<ISSessionDelegate> delegate;
@property(nonatomic, assign)NSTimeInterval bonusTime;

+ (ISSession*)session;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (id)init;

- (BOOL)start:(ISQuiz*)quiz;
- (void)stop;

- (void)setResponse:(ISQuestionResponse*)response
            atIndex:(int)index;

// inserts an empty response
- (void)clearResponseAtIndex:(int)index;

- (NSTimeInterval)time;

@end
