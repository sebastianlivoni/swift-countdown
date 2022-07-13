//
//  ContentView.swift
//  Countdown
//
//  Created by Sebastian Livoni on 01/07/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var date = Date()
    @State private var timeRemaining = "Waiting for start..."
    
    @State public var model: Model
    
    func addTimer() {
        print("addTimer")
    }
    
    func updateTimer() {
        let interval = calcRemainingSecondsFromNow(date: date)
        
        timeRemaining = formatTimeInterval(interval: interval)
    }
    
    func formatTimeInterval(interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        
        return formatter.string(from: interval) ?? "No interval"
    }
    
    
    func calcRemainingSecondsFromNow(date end: Date) -> TimeInterval {
        if end >= Date() {
            return DateInterval(start: Date(), end: date).duration
        } else {
            return TimeInterval()
        }
    }
 
    var body: some View {
        VStack {
            CountdownList(model: model)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Model())
    }
}
