//
//  AboutMe.swift
//
//
//  Created by Lucy on 6/24/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

import SwiftUI

struct AboutMe: View {
	var body: some View {
		Section(header: Text("About Me")) {
			Credit(name: "Lucy", role: "Developer", profile: .twitter("Absolucyyy"))
			Button(action: {
				if let url = URL(string: "mailto:support@absolucy.moe") {
					UIApplication.shared.open(url)
				}
			}) {
				HStack {
					Image(systemName: "envelope.fill")
						.resizable()
						.scaledToFit()
						.frame(width: 29, height: 29)
						.padding(.vertical, 5)
						.padding(.horizontal, 11)
					VStack(alignment: .leading, spacing: 5) {
						Text("Support Email")
							.font(.system(.body, design: .rounded))
						Text("support@absolucy.moe")
							.font(.system(.caption, design: .rounded))
					}
				}
			}
			TweakAdvertisement(
				name: "Xenon",
				description: "Easily share files between iOS and a PC over your network!",
				package: "me.aspenuwu.xenon",
				image: UIImage(contentsOfFile: "/Library/Lucy/LucientResources.bundle/xenon.png")
					.map(Image.init) ?? Image(systemName: "externaldrive.fill.badge.wifi")
			)
			TweakAdvertisement(
				name: "Zinnia",
				description: "Who doesn't love neon? Why not put it on your lockscreen?",
				package: "me.aspenuwu.zinnia",
				image: UIImage(contentsOfFile: "/Library/Lucy/LucientResources.bundle/zinnia.png")
					.map(Image.init) ?? Image(systemName: "lightbulb.fill")
			)
		}
	}
}
