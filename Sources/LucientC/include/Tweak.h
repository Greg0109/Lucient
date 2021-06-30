//
//  Tweak.h
//  Lucient
//
//  Created by Lucy on 6/16/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#ifndef Tweak_h
#define Tweak_h

#import "CSCoverSheetView.h"
#import "Globals.h"
#import "NSTask.h"
#import "libpddokdo.h"
#import <Foundation/Foundation.h>

extern void setNotifsVisible(BOOL);
extern void setMusicVisible(BOOL);
extern void setMusicSuggestionsVisible(BOOL);
extern void setScreenOn(BOOL);
extern BOOL isEnabled(void);
extern void removeIfInvalid(void);

UIColor* getColorFromImage(UIImage* image, int calculation, int dimension, int flexibility, int range);
BOOL isDarkImage(UIImage* image);

extern CFArrayRef CPBitmapCreateImagesFromData(CFDataRef cpbitmap, void*, int, void*);

#endif /* Tweak_h */
