//
//  12TimeView.swift
//  Lucient
//
//  Created by Lucy on 6/13/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

import SwiftUI
import UIKit

internal struct TimeView: View {
	static var view = TimeView()

	private let minuteFmt: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "mm"
		return formatter
	}()

	private let timeObserver = NotificationCenter.default.publisher(for: NSNotification.Name("moe.absolucy.lucient.time"))
		.receive(on: RunLoop.main)

	@Environment(\.colorScheme) var colorScheme
	@Preference("fontStyle", identifier: "moe.absolucy.lucient") private var fontStyle = FontStyle.ios
	@Preference("customFont",
	            identifier: "moe.absolucy.lucient") var customFont = "/Library/Lucy/LucientResources.bundle/Roboto.ttf"
	@Preference("colorMode", identifier: "moe.absolucy.lucient") private var colorMode = ColorMode.distinctive
	@Preference("color", identifier: "moe.absolucy.lucient") private var customColor = Color.primary
	@Preference("separatedColors", identifier: "moe.absolucy.lucient") private var separatedColors = false

	@Preference("minTimeSize", identifier: "moe.absolucy.lucient") var minFontSize: Double = 24
	@Preference("maxTimeSize", identifier: "moe.absolucy.lucient") var maxFontSize: Double = 160
	@Preference("timeOffset", identifier: "moe.absolucy.lucient") var timeOffset: Double = 15
	@Preference("timeOnTheRight", identifier: "moe.absolucy.lucient") private var timeOnTheRight = false
	@Preference("timeColorMode", identifier: "moe.absolucy.lucient") var timeColorMode = ColorMode.distinctive
	@Preference("timeColor", identifier: "moe.absolucy.lucient") var timeCustomColor = Color.primary
	@Preference("time24hr", identifier: "moe.absolucy.lucient") var time24Hour = false
	@Preference("timeShowAmPm", identifier: "moe.absolucy.lucient") var timeShowAmPm = false
	@State private var date = Date()
	@State private var hourFmt: DateFormatter = {
		let is24Hr: Bool = {
			guard let defaults = UserDefaults(suiteName: "/var/mobile/Library/Preferences/moe.absolucy.lucient.plist")
			else { return false }
			return defaults.object(forKey: "time24hr") as? Bool ?? false
		}()
		let formatter = DateFormatter()
		formatter.dateFormat = is24Hr ? "HH" : "hh"
		return formatter
	}()

	@State private var minFmt: DateFormatter = {
		let is24Hr: Bool = {
			guard let defaults = UserDefaults(suiteName: "/var/mobile/Library/Preferences/moe.absolucy.lucient.plist")
			else { return false }
			return defaults.object(forKey: "time24hr") as? Bool ?? false
		}()
		let showAmPm: Bool = {
			guard let defaults = UserDefaults(suiteName: "/var/mobile/Library/Preferences/moe.absolucy.lucient.plist")
			else { return false }
			return defaults.object(forKey: "timeShowAmPm") as? Bool ?? false
		}()
		let formatter = DateFormatter()
		formatter.dateFormat = is24Hr ? "HH:mm" : (showAmPm ? "hh:mm a" : "hh:mm")
		return formatter
	}()

	@ObservedObject private var shared = SharedData.global

	var body: some View {
		let color = ColorManager.instance.get(
			separatedColors,
			mode: colorMode,
			customMode: timeColorMode,
			color: customColor,
			customColor: timeCustomColor
		)
		let font = FontRegistration.font(
			size: shared.timeMinimized ? minFontSize : maxFontSize,
			style: fontStyle,
			custom: customFont
		)
		VStack(alignment: .center, spacing: 0) {
			if shared.timeMinimized && !timeOnTheRight {
				Text(minFmt.string(from: date))
					.font(font)
					.lineLimit(1)
					.foregroundColor(color)
			} else {
				Text(hourFmt.string(from: date))
					.font(font)
					.lineLimit(1)
					.foregroundColor(color)
					.offset(x: 0, y: CGFloat(timeOffset))

				Text(minuteFmt.string(from: date))
					.font(font)
					.lineLimit(1)
					.foregroundColor(color)
					.offset(x: 0, y: CGFloat(-timeOffset))
			}
		}.onReceive(timeObserver) { _ in
			date = Date()
		}.onChange(of: time24Hour) { newValue in
			hourFmt.dateFormat = newValue ? "HH" : "hh"
			minFmt.dateFormat = newValue ? "HH:mm" : (timeShowAmPm ? "hh:mm a" : "hh:mm")
		}
		.onChange(of: timeShowAmPm) { newValue in
			if !time24Hour {
				minFmt.dateFormat = newValue ? "hh:mm a" : "hh:mm"
			}
		}
		.onChange(of: colorScheme) { _ in
			NSLog("[Lucient] color scheme change detected, updating wallpaper!")
			DispatchQueue.main.async(qos: .background) {
				ColorManager.instance.updateWallpaper()
			}
		}
		.padding(.trailing)
	}
}

@_cdecl("makeTimeView")
internal func makeTimeView() -> UIViewController? {
	UIHostingController(rootView: TimeView.view)
}
