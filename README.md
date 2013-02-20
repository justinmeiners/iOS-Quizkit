iOS-Quizkit
===========

Takes care of the model layer for apps with quizzes and tests. Contrary to the title this API should work on Mac as well.

This project is not yet complete. It is 99% there.

An example project is coming soon.

Features:
- Multiple choice questions
- Open response questions with optional Levenshtein distance range
- True/False questions
- Full NSCodor support for quizzes, questions, and sessions.
- Load quizzes from user created Plists.


```Objective-C
// Load Quiz From User PLIST
[ISQuizParser quizFromContentsOfPlist:...];

// Load Quiz From JSON
[ISQuizParser quizFromContentsOfJSON:...];

```