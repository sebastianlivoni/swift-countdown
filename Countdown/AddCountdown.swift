//
//  AddCountdown.swift
//  Countdown
//
//  Created by Sebastian Livoni on 02/07/2022.
//

import SwiftUI

struct AddCountdown: View {
    @Environment(\.dismiss) var dismiss
    
    @State var model: Model
    
    @State var name: String = ""
    @State var description: String = ""
    @State var endDate: Date = Date()
    @State var notificationEnabled: Bool = false
    
    func createCountdown() {
        let newCountdown = Countdown(name: name, description: description, endDate: endDate, imageName: "birthday")

        model.countdowns.append(newCountdown)
        
        dismiss()
    }
 
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("INFORMATION ABOUT THE EVENT")) {
                        TextField("Name of event", text: $name)
                        
                        TextField("Description of event", text: $description)
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
                    
                    Button("Create new countdown", action: createCountdown)
                }
            }
            
            .navigationTitle("Add Countdown")
            .navigationBarItems(
                trailing: Button("Dismiss") {
                    dismiss()
                }
            )
        }
    }
}

struct AddCountdown_Previews: PreviewProvider {
    static var previews: some View {
        AddCountdown(model: Model())
    }
}
