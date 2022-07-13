//
//  CountdownApp.swift
//  Countdown
//
//  Created by Sebastian Livoni on 01/07/2022.
//

import SwiftUI

@main
struct CountdownApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: Model())
        }
    }
}
