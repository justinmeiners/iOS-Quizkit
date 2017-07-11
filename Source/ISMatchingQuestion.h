//
//  ISMatchingQuestion.h
//  iOS-QuizKit
//
//  Created by Christian French on 17/06/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import "ISQuestion.h"

@interface ISMatchingResponse : ISQuestionResponse

@property(nonatomic, strong)NSArray* options;
/*
 Submit an answer option for each question option in the order of the question options.
 
 example
 question.options [1,two,3,four]
 question.answers [2,one,4,three]
 response.options [one,2,three,4]
 */

+ (ISMatchingResponse*)responseWithOptions:(NSArray*)options;

- (id)initWithCoder:(NSCoder *)aDecoder;

- (void)encodeWithCoder:(NSCoder *)aCoder;

@end

@interface ISMatchingOption : NSObject <NSCoding>
@property(nonatomic, strong) NSDictionary* userData;
@property(nonatomic, copy) NSString* text;
@property(nonatomic, strong) ISMatchingOption* matchingOption;


- (id)initWithCoder:(NSCoder *)aDecoder;

- (void)encodeWithCoder:(NSCoder *)aCoder;

+ (ISMatchingOption*)optionWithText:(NSString*)text;

+ (ISMatchingOption*)optionWithText:(NSString*)text matchingOption:(ISMatchingOption*)matchingOption;

@end

@interface ISMatchingQuestion : ISQuestion

@property(nonatomic, strong) NSArray* options;

@property(nonatomic, strong) NSArray* answers;

@property(nonatomic, strong) NSArray* randomizedAnswers;

+ (instancetype)questionWithOptions:(NSArray*)options answers:(NSArray*)answers;

@end
