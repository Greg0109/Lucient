//
//  CSCoverSheetViewController.m
//  Lucient
//
//  Created by Lucy on 6/13/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#import "../include/Hooks.h"
#import "../include/Tweak.h"

void (*orig_CSCoverSheetViewController_viewWillAppear)(UIViewController* self, SEL cmd, BOOL animated);
void hook_CSCoverSheetViewController_viewWillAppear(UIViewController* self, SEL cmd, BOOL animated) {
	setScreenOn(YES);
	return orig_CSCoverSheetViewController_viewWillAppear(self, cmd, animated);
}

void (*orig_CSCoverSheetViewController_viewDidDisappear)(UIViewController* self, SEL cmd, BOOL animated);
void hook_CSCoverSheetViewController_viewDidDisappear(UIViewController* self, SEL cmd, BOOL animated) {
	setScreenOn(NO);
	return orig_CSCoverSheetViewController_viewDidDisappear(self, cmd, animated);
}
