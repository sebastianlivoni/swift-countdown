//
//  Countdown.swift
//  Countdown
//
//  Created by Sebastian Livoni on 02/07/2022.
//

import Foundation
import SwiftUI

struct Countdown: Hashable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var endDate: Date
    
    var imageName: String
    var image: Image {
        Image(imageName)
    }
}

class Model: ObservableObject {
    @Published var countdowns: [Countdown]
    
    init() {
        self.countdowns = [
            Countdown(name: "Seb's Birthday", description: "A countdown until my birthday. Will check daily!", endDate: Date(timeIntervalSinceReferenceDate: 685670400), imageName: "birthday"),
            Countdown(name: "Christmas Day", description: "This is Christmas", endDate: Date(timeIntervalSinceReferenceDate: 693532800), imageName: "birthday"),
            Countdown(name: "Thanksgiving", description: "This is Thanksgiving", endDate: Date(timeIntervalSinceReferenceDate: 690940800), imageName: "birthday")
        ]
    }
    
    func find(countdown: Countdown) -> Int {
        return self.countdowns.firstIndex(of: countdown) ?? -1
    }
    
    func update(countdown: Countdown, Updated: Countdown) {
        if let index = self.countdowns.firstIndex(of: countdown) {
            self.countdowns[index] = Updated
        }
    }
}
