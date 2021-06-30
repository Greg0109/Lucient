//
//  CSCombinedListViewController.m
//  Lucient
//
//  Created by Lucy on 6/13/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#import "../include/Hooks.h"

UIEdgeInsets (*orig_CSCombinedListViewController_listViewDefaultContentInsets)(UIViewController* self, SEL cmd);
UIEdgeInsets hook_CSCombinedListViewController_listViewDefaultContentInsets(UIViewController* self, SEL cmd) {
	UIEdgeInsets orig = orig_CSCombinedListViewController_listViewDefaultContentInsets(self, cmd);
	orig.top += 64;
	return orig;
}
