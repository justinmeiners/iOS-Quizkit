/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>
#import "ISQuestion.h"

@interface ISTrueFalseResponse : ISQuestionResponse

@property(nonatomic, assign)BOOL response;

+ (ISTrueFalseResponse*)responseWithResponse:(BOOL)response;

- (id)initWithResponse:(BOOL)response;
- (id)init;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end


@interface ISTrueFalseQuestion : ISQuestion

@property(nonatomic, assign)BOOL answer;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (BOOL)responseCorrect:(ISQuestionResponse*)response;

@end
