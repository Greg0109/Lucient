//
//  MRUNowPlayingView.m
//
//
//  Created by Lucy on 6/23/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#include "../include/Tweak.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

BOOL (*orig_MRUNowPlayingView_showSuggestionsView)(UIView* self, SEL cmd);
BOOL hook_MRUNowPlayingView_showSuggestionsView(UIView* self, SEL cmd) {
	BOOL orig = orig_MRUNowPlayingView_showSuggestionsView(self, cmd);
	setMusicSuggestionsVisible(orig);
	return orig;
}

void (*orig_MRUNowPlayingView_setShowSuggestionsView)(UIView* self, SEL cmd, BOOL arg1);
void hook_MRUNowPlayingView_setShowSuggestionsView(UIView* self, SEL cmd, BOOL arg1) {
	setMusicSuggestionsVisible(arg1);
	orig_MRUNowPlayingView_setShowSuggestionsView(self, cmd, arg1);
}
