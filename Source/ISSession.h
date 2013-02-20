/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import <Foundation/Foundation.h>
#import "ISQuiz.h"

@class ISSession;

@protocol ISSessionDelegate <NSObject>

@optional
- (void)sessionStarted:(ISSession*)session;
- (void)sessionFinished:(ISSession*)session;

- (void)sessionPaused:(ISSession*)session;
- (void)sessionResumed:(ISSession*)session;

- (void)sessionHitTimeLimit:(ISSession*)session;

@end

@interface ISSession : NSObject <NSCoding>
{
    NSDate* _startDate;
    NSDictionary* _userData;
    NSMutableArray* _responses;
    BOOL _inSession;
    BOOL _paused;
    id <ISSessionDelegate> _delegate;
}
@property(nonatomic, copy)NSDate* startDate;
@property(nonatomic, readonly)NSArray* responses;
@property(nonatomic, retain)NSDictionary* userData;
@property(nonatomic, readonly)BOOL inSession;
@property(nonatomic, assign)BOOL paused;
@property(nonatomic, assign)id<ISSessionDelegate> delegate;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (id)init;

- (BOOL)start:(ISQuiz*)quiz;
- (void)finish;

- (void)setResponse:(ISQuestionResponse*)response
            atIndex:(int)index;

// inserts an empty response
- (void)clearResponseAtIndex:(int)index;

@end
