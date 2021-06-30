//
//  PreferencesController.swift
//
//
//  Created by Lucy on 6/21/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

import SwiftUI

class PreferencesController: NomaePreferencesController {
	override var suiView: AnyView {
		get { AnyView(Preferences()) }
		set { super.suiView = newValue }
	}
}
