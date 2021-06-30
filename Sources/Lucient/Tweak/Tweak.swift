//
//  Tweak.swift
//
//
//  Created by Lucy on 6/21/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation
import LucientC

@_cdecl("isEnabled")
internal func isEnabled() -> Bool {
	guard let defaults = UserDefaults(suiteName: "/var/mobile/Library/Preferences/moe.absolucy.lucient.plist") else {
		return true
	}
	guard let enabled = defaults.object(forKey: "enabled") as? Bool? else {
		return true
	}
	return enabled ?? true
}
