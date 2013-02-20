//
//  OpenQuestionViewController.h
//  QuizKitSample
//
//  Created by Justin Meiners on 2/20/13.
//  Copyright (c) 2013 Infuse Medical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISQuizKit.h"

@interface OpenQuestionViewController : UIViewController
{
    IBOutlet UITextView* _questionTextView;
    IBOutlet UITextField* _responseField;
}

- (id)initWithOpenQuestion:(ISOpenQuestion*)question
                  response:(ISOpenQuestionResponse*)response;

@end
