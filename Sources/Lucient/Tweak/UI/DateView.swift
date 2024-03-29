//
//  DateView.swift
//  Lucient
//
//  Created by Lucy on 6/13/21.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

import EventKit
import LucientC
import SwiftUI

internal struct DateView: View {
	static var view = DateView()

	private let dateFmt: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "E, MMM d"
		return formatter
	}()

	private let timeFmt: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "hh:mm"
		return formatter
	}()

	private let durationFmt: DateComponentsFormatter = {
		let formatter = DateComponentsFormatter()
		formatter.allowedUnits = [.day, .hour, .minute]
		formatter.unitsStyle = .full
		formatter.maximumUnitCount = 1
		return formatter
	}()

	private let flipObserver = NotificationCenter.default.publisher(for: NSNotification.Name("moe.absolucy.lucient.flip"))
		.receive(on: RunLoop.main)
	private let timeObserver = NotificationCenter.default.publisher(for: NSNotification.Name("moe.absolucy.lucient.time"))
		.receive(on: RunLoop.main)
	private let weatherObserver = NotificationCenter.default
		.publisher(for: NSNotification.Name("moe.absolucy.lucient.weather"))
		.receive(on: RunLoop.main)
	private let ekStore = EKEventStore()

	@Preference("fontStyle", identifier: "moe.absolucy.lucient") private var fontStyle = FontStyle.ios
	@Preference("customFont",
	            identifier: "moe.absolucy.lucient") var customFont = "/Library/Lucy/LucientResources.bundle/Roboto.ttf"
	@Preference("colorMode", identifier: "moe.absolucy.lucient") private var colorMode = ColorMode.distinctive
	@Preference("color", identifier: "moe.absolucy.lucient") private var customColor = Color.primary
	@Preference("separatedColors", identifier: "moe.absolucy.lucient") private var separatedColors = false

	@Preference("showWeather", identifier: "moe.absolucy.lucient") private var showWeather = true
	@Preference("minTimeSize", identifier: "moe.absolucy.lucient") private var timeSize: Double = 24
	@Preference("dateFontSize", identifier: "moe.absolucy.lucient") private var fontSize: Double = 24
	@Preference("dateOffset", identifier: "moe.absolucy.lucient") private var offset: Double = 0
	@Preference("dateColorMode", identifier: "moe.absolucy.lucient") var dateColorMode = ColorMode.distinctive
	@Preference("dateColor", identifier: "moe.absolucy.lucient") var dateCustomColor = Color.primary
	@Preference("time24hr", identifier: "moe.absolucy.lucient") var time24Hour = false
	@State private var showingEvent = false
	@State private var date = Date()
	@State private var calFmt: DateFormatter = {
		let is24Hr: Bool = {
			guard let defaults = UserDefaults(suiteName: "/var/mobile/Library/Preferences/moe.absolucy.lucient.plist")
			else { return false }
			return defaults.object(forKey: "time24hr") as? Bool ?? false
		}()
		let formatter = DateFormatter()
		formatter.dateFormat = is24Hr ? "HH:mm" : "hh:mm a"
		return formatter
	}()

	@ObservedObject private var shared = SharedData.global

	init() {
		ekStore.requestAccess(to: .event) { _, error in
			if let error = error {
				NSLog("[Lucient] failed to get access to events: \(error)")
			}
		}
		ekStore.requestAccess(to: .reminder) { _, error in
			if let error = error {
				NSLog("[Lucient] failed to get access to reminders: \(error)")
			}
		}
	}

	private func getEvents() -> [EKEvent] {
		let calendar = Calendar.current
		var dayComponents = DateComponents()
		dayComponents.day = 0
		let today = calendar.date(byAdding: dayComponents, to: Date())

		var tomorrowComponents = DateComponents()
		tomorrowComponents.day = 1
		let tomorrow = calendar.date(byAdding: tomorrowComponents, to: Date())

		var predicate: NSPredicate?
		if let aToday = today, let aTomorrow = tomorrow {
			predicate = ekStore.predicateForEvents(withStart: aToday, end: aTomorrow, calendars: nil)
		}

		var events: [EKEvent]?
		if let aPredicate = predicate {
			events = ekStore.events(matching: aPredicate)
		}

		return events ?? []
	}

	@ViewBuilder
	private func ReminderView(_ color: Color, _ font: Font, _ event: EKEvent) -> some View {
		let string: String = {
			var string = durationFmt.string(from: Date().distance(to: event.startDate))!
			if let title = event.title {
				string.append(": \(title)")
			}
			if let location = event.location {
				string.append(contentsOf: " @ \(location)")
			}
			return string
		}()
		VStack(alignment: .leading) {
			Text(string)
				.font(font)
				.foregroundColor(color)
			HStack {
				Image(systemName: "calendar")
				Text("\(calFmt.string(from: event.startDate)) - \(calFmt.string(from: event.endDate))")
					.font(font)
					.foregroundColor(color)
			}
		}
	}

	var body: some View {
		let color = ColorManager.instance.get(
			separatedColors,
			mode: colorMode,
			customMode: dateColorMode,
			color: customColor,
			customColor: dateCustomColor
		)
		let font = FontRegistration.font(size: fontSize, style: fontStyle, custom: customFont)
		let event = getEvents().filter { $0.startDate > Date() && $0.startDate <= Date().addingTimeInterval(86400) }
			.sorted { $0.startDate < $1.startDate }.first
		VStack(alignment: .leading, spacing: 0) {
			if showingEvent,
			   let event = event
			{
				ReminderView(color, font, event)
					.transition(.opacity)
			} else {
				Text(dateFmt.string(from: date))
					.font(font)
					.foregroundColor(color)
					.offset(x: 0, y: CGFloat(offset))
					.transition(.opacity)
				if showWeather, let temperature = shared.temperature, let image = shared.weatherImage {
					HStack {
						image
							.resizable()
							.scaledToFit()
							.frame(width: CGFloat(fontSize * 2), height: CGFloat(fontSize * 2))
						Text(temperature)
							.font(font)
							.foregroundColor(color)
						Spacer()
					}
					.offset(x: 0, y: CGFloat(-offset))
					.transition(.opacity)
				}
			}
		}
		.transition(.opacity)
		.onReceive(timeObserver) { _ in
			date = Date()
		}
		.onReceive(weatherObserver) { _ in
			shared.updateWeather()
		}
		.onReceive(flipObserver) { _ in
			withAnimation(.linear(duration: 0.5)) {
				showingEvent.toggle()
			}
		}
		.onChange(of: time24Hour) { newValue in
			calFmt.dateFormat = newValue ? "HH:mm" : "hh:mm a"
		}
	}
}

@_cdecl("makeDateView")
internal func makeDateView() -> UIViewController? {
	UIHostingController(rootView: DateView.view)
}
