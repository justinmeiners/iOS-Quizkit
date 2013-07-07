/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>
#import "ISQuestion.h"

@interface ISGradingResult : NSObject
@property(nonatomic, assign)float pointPercentage;
@property(nonatomic, assign)int pointsPossible;
@property(nonatomic, assign)int points;
@property(nonatomic, assign)int questionsCorrect;
@property(nonatomic, assign)int questionsPossible;
@property(nonatomic, assign)float questionPercentage;
@end

@class ISSession;

@interface ISQuiz : NSObject <NSCoding>
{
    NSMutableArray* _questions;
    NSTimeInterval _timeLimit;
}
@property(nonatomic, readonly)NSArray* questions;
@property(nonatomic, assign)NSTimeInterval timeLimit;

+ (ISGradingResult*)gradeSession:(ISSession*)session quiz:(ISQuiz*)quiz;

- (id)init;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (ISGradingResult*)gradeSession:(ISSession*)session;

- (void)addQuestion:(ISQuestion*)question;
- (void)removeQuestion:(ISQuestion*)question;
- (void)removeAllQuestions;


@end
