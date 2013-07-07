/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>
#import "ISQuiz.h"
#import "ISSession.h"


static NSString * const kISQuestionTypeOpen = @"open";
static NSString * const kISQuestionTypeMultipleChoice = @"multipleChoice";
static NSString * const kISQuestionTypeTrueFalse = @"trueFalse";

static NSString * const kISTypeKey = @"type";
static NSString * const kISQuestionsKey = @"questions";
static NSString * const kISTextKey = @"text";
static NSString * const kISAnswerKey = @"answer";
static NSString * const kISAnswersKey = @"answers";
static NSString * const kISOptionsKey = @"options";
static NSString * const kISCorrectKey = @"correct";
static NSString * const kISMatchModeKey = @"matchMode";
static NSString * const kISScoreValueKey = @"scoreValue";


@interface ISQuizParser : NSObject

// does not do UIImage style caching, just a shorcut for NSBundle
+ (ISQuiz*)quizNamed:(NSString*)name; // NSEncoder - unless extension is .plist or .json

+ (ISQuiz*)quizWithContentsOfFile:(NSString*)file; // NSEncoder
+ (ISQuiz*)quizFromContentsOfPlist:(NSString*)file; // plist
+ (ISQuiz*)quizFromContentsOfJSON:(NSString*)jsonFile; // json
+ (ISQuiz*)quizFromDictionary:(NSDictionary*)dictionary;

@end
