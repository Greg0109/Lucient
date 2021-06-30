//
//  Globals.h
//  Lucient
//
//  Created by Lucy on 6/17/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#ifndef Globals_h
#define Globals_h

#import "CSCoverSheetView.h"
#import <UIKit/UIKit.h>

extern UIViewController* timeView;
extern NSLayoutConstraint* timeConstraintCx;
extern NSLayoutConstraint* timeConstraintCy;
extern NSLayoutConstraint* timeConstraintDateTop;
extern NSLayoutConstraint* timeConstraintDateBottom;
extern NSLayoutConstraint* timeConstraintDateLeft;
extern NSLayoutConstraint* timeConstraintRight;

extern UIViewController* dateView;
extern CSCoverSheetView* coverSheetView;

#endif /* Globals_h */
