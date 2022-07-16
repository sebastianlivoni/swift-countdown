//
//  CountdownView.swift
//  Countdown
//
//  Created by Sebastian Livoni on 02/07/2022.
//

import SwiftUI

struct DetailView: View {
    let countdown: CountdownEntity
    
    @State private var showingAddScreen = false
    @State var timeRemaining = ""
    
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d. MMMM yyyy"
        return formatter.string(from: countdown.endDate ?? Date()).lowercased()
    }
    
    func timeRemainingInText() -> String {
        let formatter = DateComponentsFormatter()
        let remainingInterval = DateInterval(start: Date(), end: countdown.endDate ?? Date()).duration
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day]
        
        return formatter.string(from: remainingInterval) ?? "No interval"
    }
    
    func edit() {
        showingAddScreen = true
    }
    
    var body: some View {
        VStack {
            Text(countdown.desc ?? "No description")
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
        
        .navigationBarTitle(countdown.name ?? "No name")
        .navigationBarItems(
            trailing: Button(action: edit) {
                Text("Rediger")
            }
        )
        .fullScreenCover(isPresented: $showingAddScreen) {
            EditCountdownView(countdown: countdown)
        }
    }
    
    var widget: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(LinearGradient(gradient: Gradient(colors: [Color("lightpink"), Color("orange")]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 225, height: 225)
        .overlay(
            VStack(alignment: .center) {
                Text(countdown.name ?? "No name")
                    .fontWeight(.medium)
                    .font(.system(size: 20))
                
                Spacer()
                
                Text(timeRemainingInText())
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                
                Spacer()
                
                Text(formatDate())
                    .font(.system(size: 16))
                    .fontWeight(.heavy)
            }
                .padding(.vertical, 20.0)
                .foregroundColor(Color.white)
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let dataController = DataController()
        let context = dataController.container.viewContext
        
        let countdown = CountdownEntity(context: context)
        countdown.name = "hej"
        
        return NavigationView {
            DetailView(countdown: countdown)
        }
    }
}
