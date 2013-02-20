/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import <Foundation/Foundation.h>
#import "ISQuestion.h"

@interface ISQuiz : NSObject <NSCoding>
{
    NSMutableArray* _questions;
    NSTimeInterval _timeLimit;
}
@property(nonatomic, readonly)NSArray* questions;
@property(nonatomic, assign)NSTimeInterval timeLimit;

- (id)init;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (void)addQuestion:(ISQuestion*)question;
- (void)removeQuestion:(ISQuestion*)question;
- (void)removeAllQuestions;


@end
