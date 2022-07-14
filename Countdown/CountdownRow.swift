//
//  CountdownsView.swift
//  Countdown
//
//  Created by Sebastian Livoni on 02/07/2022.
//

import SwiftUI

struct CountdownRow: View {
    var countdown: CountdownEntity
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d. MMMM yyyy"
        return formatter.string(from: countdown.endDate ?? Date()).lowercased()
    }
    
    func timeRemaining() -> String {
        let formatter = DateComponentsFormatter()
        let remainingInterval = DateInterval(start: Date(), end: countdown.endDate ?? Date()).duration
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day, .hour, .minute]
        
        return formatter.string(from: remainingInterval) ?? "No interval"
    }
    
    var body: some View {
        HStack {
            Image("birthday")
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(countdown.name ?? "No name")
                Text(timeRemaining())
                    .font(.system(size: 12))
                Text(formatDate())
                    .font(.system(size: 12))
            }
            
            Spacer()
        }
    }
}

/*
struct CountdownRow_Previews: PreviewProvider {
    static var previews: some View {
        let countdown = Countdown(name: "Seb's Birthday", description: "A countdown until my birthday. Will check daily!", endDate: Date(timeIntervalSinceReferenceDate: 685670400), imageName: "birthday")
        
        CountdownRow(countdown: countdown)
    }
}
*/
