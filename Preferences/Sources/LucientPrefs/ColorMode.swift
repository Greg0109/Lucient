//
//  ColorMode.swift
//
//
//  Created by Lucy on 6/22/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation

enum ColorMode: Int, Codable {
	case custom = 0
	case distinctive = 1
	case primary = 2
	case secondary = 3
	case background = 4
}
