//
//  SwiftUIView.swift
//
//
//  Created by Lucy on 6/24/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

import SwiftUI

struct SizeOption: View {
	var name: String
	var option: Binding<Double>
	var min: Double
	var max: Double
	var defaultOption: Double

	var body: some View {
		VStack(spacing: 0) {
			Text(name).padding(.vertical, 5)
			HStack {
				Spacer()
				Text(String(format: "%.0f", option.wrappedValue))
					.font(.system(.footnote, design: .rounded))
				Spacer()
			}.padding(.vertical, 5)
			HStack {
				Text(String(format: "%.0f", min))
					.font(.caption2)
				Slider(value: option, in: min ... max, step: 1) { _ in }
				Text(String(format: "%.0f", max))
					.font(.caption2)
			}
		}
		.onTapGesture(count: 2) {
			option.wrappedValue = defaultOption
		}
	}
}
