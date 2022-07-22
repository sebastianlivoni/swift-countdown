//
//  CountdownsView.swift
//  Countdown
//
//  Created by Sebastian Livoni on 02/07/2022.
//

import SwiftUI

struct CountdownRow: View {
    var countdown: CountdownEntity
    
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    @State var timeRemaining = ""
    
    var body: some View {
        HStack {
            Image("birthday")
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(countdown.name ?? "No name")
                Text("\(timeRemaining)")
                    .font(.system(size: 12))
                    .onReceive(timer) { _ in
                        self.timeRemaining = countdown.timeRemaining(units: [.month, .day, .hour, .minute, .second])
                    }
                    .onAppear {
                        self.timeRemaining = countdown.timeRemaining(units: [.month, .day, .hour, .minute, .second])
                    }
                Text(countdown.formatDate())
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
