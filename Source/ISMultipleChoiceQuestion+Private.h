//
//  ISMultipleChoiceQuestion_ISMultipleChoiceQuestion_Private.h
//  iOS-QuizKit
//
//  Created by Christian French on 12/09/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import "ISMultipleChoiceQuestion.h"

@interface ISMultipleChoiceQuestion ()

@property(nonatomic,strong) NSArray* randomizedIndexesMap;

-(void)randomizeOptions;

@end
