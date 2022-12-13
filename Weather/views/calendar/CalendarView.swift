//
//  ContentView.swift
//  Calendar
//
//  Created by iosdev on 9.12.2022.
//

import SwiftUI
import EventKit

class CalendarEvent: Identifiable, ObservableObject {
    let id = UUID()
    let place: String
    let title: String
    let startDate: Date

    init(place: String, title: String, startDate: Date) {
        self.place = place
        self.title = title
        self.startDate = startDate
    }
}

struct CalendarView: View {
    @StateObject var fmi = FMI()
    let eventStore = EKEventStore()
    @State var calendarEvents: [CalendarEvent] = []
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Text("calendar")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            Divider()
            
            List {
                ForEach(calendarEvents) { e in
                    if fmi.data[e.place] != nil && fmi.data[e.place]!.count > 0 {
                        CalendarRowView(calendarEvent: e, weather: fmi.data[e.place]!)
                    }
                }
            }
            .onAppear {
                getCalendar()
                for e in calendarEvents {
                    if fmi.data[e.place] == nil {
                        fmi.getForecast(place: e.place)
                    }
                }
            }
        }
    }
}

extension CalendarView {
    func getEvents() {
        print("getting events")
        calendarEvents = []
        for calendar in eventStore.calendars(for: .event) {
            let predicate = eventStore.predicateForEvents(
                withStart: Date(),
                end: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                calendars: [calendar]
            )
            let events = eventStore.events(matching: predicate)
            for event in events {
                if let place = event.location?.components(separatedBy: "\n")[0] {
                    calendarEvents.append(CalendarEvent(
                        place: place,
                        title: event.title,
                        startDate: event.startDate
                    ))
                }
            }
        }
    }
    
    func getCalendar() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        switch status {
        case .authorized:
            getEvents()
        case .denied:
            print("Access denied")
        case .notDetermined:
            requestAccess()
        default:
            break
        }
    }
    
    func requestAccess() {
        eventStore.requestAccess(to: EKEntityType.event) { granted, error in
            if let error = error {
                print(error)
                return
            }
            
            if granted {
                getEvents()
            }
        }
    }
}


