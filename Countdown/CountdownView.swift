//
//  CountdownView.swift
//  Countdown
//
//  Created by Sebastian Livoni on 02/07/2022.
//

import SwiftUI

struct CountdownView: View {
    let countdown: Countdown
    
    @State var activeSheet: Countdown?
    @State var timeRemaining = ""
    @ObservedObject var model: Model
    
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    func timeRemainingInText() -> String {
        let remainingInterval = calcRemainingSecondsFromNow(date: countdown.endDate)
        
        return formatTimeInterval(interval: remainingInterval)
    }
    
    func formatTimeInterval(interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = .day
        
        return formatter.string(from: interval) ?? "No interval"
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d. MMMM yyyy"
        return formatter.string(from: date).lowercased()
    }
    
    func calcRemainingSecondsFromNow(date end: Date) -> TimeInterval {
        if end >= Date() {
            return DateInterval(start: Date(), end: end).duration
        } else {
            return TimeInterval()
        }
    }
    
    func edit() {
        activeSheet = countdown
    }
    
    var body: some View {
        VStack {
            Text(countdown.description)
                .font(.body)
            
            widget
            
            Spacer()
        }
        .onReceive(timer) { _ in
            self.timeRemaining = timeRemainingInText()
        }
        .onAppear {
            self.timeRemaining = timeRemainingInText()
        }
        .padding(.all, 20)
        
        .navigationBarTitle(countdown.name)
        .navigationBarItems(
            trailing: Button(action: edit) {
                Text("Rediger")
            }
        )
        .fullScreenCover(item: $activeSheet) { item in
            EditCountdown(countdown: item, model: model)
        }
    }
    
    var widget: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(LinearGradient(gradient: Gradient(colors: [Color("lightpink"), Color("orange")]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 225, height: 225)
        .overlay(
            VStack(alignment: .center) {
                Text(countdown.name)
                    .fontWeight(.medium)
                    .font(.system(size: 20))
                
                Spacer()
                
                Text(timeRemaining)
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                
                Spacer()
                
                Text("\(formatDate(date: countdown.endDate))")
                    .font(.system(size: 16))
                    .fontWeight(.heavy)
            }
                .padding(.vertical, 20.0)
                .foregroundColor(Color.white)
        )
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        let countdown = Countdown(name: "Seb's Birthday", description: "A countdown until my birthday. Will check daily!", endDate: Date(timeIntervalSinceReferenceDate: 685670400), imageName: "birthday")
        
        NavigationView {
            CountdownView(countdown: countdown, model: Model())
        }
        .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
