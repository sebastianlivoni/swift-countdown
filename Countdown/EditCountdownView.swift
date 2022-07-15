//
//  EditCountdown.swift
//  Countdown
//
//  Created by Sebastian Livoni on 03/07/2022.
//

import SwiftUI

struct EditCountdownView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var viewContext
    
    @State var countdown: CountdownEntity
    
    @State var name: String = ""
    @State var description: String = ""
    @State var imageName: String = ""
    @State var endDate: Date = Date()
    @State var notificationEnabled: Bool = false
    
    func updateCountdown() {
        countdown.name = name
        countdown.desc = description
        countdown.endDate = endDate
        countdown.imageName = imageName
        
        if endDate > Date() {
            try? viewContext.save()
            dismiss()
        }
    }
    
    func deleteCountdown() {
        viewContext.delete(countdown)
        
        try? viewContext.save()
        
        dismiss()
    }
 
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("INFORMATION ABOUT THE EVENT")) {
                        TextField("Name of event", text: $name)
                            .onAppear() {
                                self.name = countdown.name ?? "No name"
                            }
                        
                        TextField("Description of event", text: $description)
                            .onAppear() {
                                self.description = countdown.desc ?? "No desc"
                            }
                    }
                    
                    Section(header: Text("DECORATION")) {
                        TextField("What image do you want?", text: $imageName)
                            .onAppear() {
                                self.imageName = countdown.imageName ?? "birthday"
                            }
                    }
                    
                    Section(header: Text("DATE")) {
                        DatePicker("Select end date", selection: $endDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    }
                    
                    Section(header: Text("NOTIFICATIONS")) {
                        Toggle(isOn: $notificationEnabled) {
                            Text("Notifications")
                        }
                    }
                    
                    Button("Update this countdown", action: updateCountdown)
                    Button(action: deleteCountdown) {
                        Text("Delete this countdown")
                            .foregroundColor(Color.red)
                    }
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

/*struct EditCountdownView_Previews: PreviewProvider {
    
    static var previews: some View {
        EditCountdown(countdown: Countdown(name: "Din lort", description: "lort", endDate: Date(timeIntervalSinceReferenceDate: 8686868), imageName: "birthday"), model: Model())
    }
}*/
