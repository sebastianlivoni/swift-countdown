//
//  CountdownsView.swift
//  Countdown
//
//  Created by Sebastian Livoni on 02/07/2022.
//

import SwiftUI

struct CountdownRow: View {
    var countdown: Countdown
    
    var body: some View {
        HStack {
            Image("birthday")
                .resizable()
                .frame(width: 50, height: 50)
            Text(countdown.name)
            
            Spacer()
        }
    }
}

struct CountdownRow_Previews: PreviewProvider {
    static var previews: some View {
        let countdown = Countdown(name: "Seb's Birthday", description: "A countdown until my birthday. Will check daily!", endDate: Date(timeIntervalSinceReferenceDate: 685670400), imageName: "birthday")
        
        CountdownRow(countdown: countdown)
    }
}
