//
//  NCNotificationListSectionRevealHintView.m
//  Lucient
//
//  Created by Lucy on 6/13/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#import "../include/Hooks.h"

id (*orig_NCNotificationListSectionRevealHintView_initWithFrame)(UIView* self, SEL cmd, CGRect frame);
id hook_NCNotificationListSectionRevealHintView_initWithFrame(UIView* self, SEL cmd, CGRect frame) {
	return nil;
}
