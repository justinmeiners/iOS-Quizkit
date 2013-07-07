/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>
#import "ISQuestion.h"

@interface ISOpenQuestionResponse : ISQuestionResponse
@property(nonatomic, copy)NSString* response;

+ (ISOpenQuestionResponse*)responseWithResponse:(NSString*)response;

- (id)init;
- (id)initWithResponse:(NSString*)response;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;
@end

typedef BOOL (^ISMatchFunc_t)(NSString* answer, NSString* response);


typedef enum
{
    kISOpenQuestionMatchModeClose = 0, // May ignore exact spelling DEFAULT
    kISOpenQuestionMatchModeExact, // Same characters - but not same case
    kISOpenQuestionMatchModeCaseSensitive, // Case sensitve Exact match
    kISOpenQuestionMatchModeCustom // code will use a custom match block
    
} ISOpenQuestionMatchMode;

@interface ISOpenQuestion : ISQuestion
{
    NSMutableArray* _answers;
}

@property(nonatomic, readonly)NSArray* answers;
@property(nonatomic, assign)ISOpenQuestionMatchMode matchMode;
@property(nonatomic, copy)ISMatchFunc_t customMatchFunc; // only works on custom match mode

- (id)init;
- (id)initWithAnswers:(NSArray*)answers;
- (id)initWithAnswer:(NSString*)answer;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (BOOL)responseCorrect:(ISQuestionResponse*)response;

- (void)addAnswer:(NSString*)answer;
- (void)addAnswers:(NSArray*)answers;
- (void)removeAllAnswers;

@end
