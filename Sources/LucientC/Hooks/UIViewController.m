//
//  UIViewController.m
//  Lucient
//
//  Created by Lucy on 6/13/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#import "../include/Hooks.h"

BOOL (*orig_UIViewController_canShowWhileLocked)(UIViewController* self, SEL cmd);
BOOL hook_UIViewController_canShowWhileLocked(UIViewController* self, SEL cmd) {
	return YES;
}
