//
//  EditCountdown.swift
//  Countdown
//
//  Created by Sebastian Livoni on 03/07/2022.
//

import SwiftUI

struct EditCountdown: View {
    @Environment(\.dismiss) var dismiss
    
    @State var countdown: Countdown
    @ObservedObject var model: Model
    
    @State var name: String = ""
    @State var description: String = ""
    @State var endDate: Date = Date()
    @State var notificationEnabled: Bool = false
    
    func updateCountdown() {
        
        model.update(countdown: countdown, Updated: Countdown(name: name, description: description, endDate: endDate, imageName: "birthday"))
        
        dismiss()
    }
 
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("INFORMATION ABOUT THE EVENT")) {
                        TextField("Name of event", text: $name)
                            .onAppear() {
                                self.name = countdown.name
                            }
                        
                        TextField("Description of event", text: $description)
                            .onAppear() {
                                self.description = countdown.description
                            }
                    }
                    
                    Section(header: Text("DATE")) {
                        DatePicker("Select end date", selection: $endDate, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    }
                    
                    Section(header: Text("NOTIFICATIONS")) {
                        Toggle(isOn: $notificationEnabled) {
                            Text("Notifications")
                        }
                    }
                    
                    Button("Update countdown", action: updateCountdown)
                }
            }
            
            .navigationTitle("Update Countdown")
            .navigationBarItems(
                trailing: Button("Dismiss") {
                    dismiss()
                }
            )
        }
    }
}

struct EditCountdown_Previews: PreviewProvider {
    
    static var previews: some View {
        EditCountdown(countdown: Countdown(name: "Din lort", description: "lort", endDate: Date(timeIntervalSinceReferenceDate: 8686868), imageName: "birthday"), model: Model())
    }
}
