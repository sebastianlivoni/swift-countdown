//
//  AddCountdown.swift
//  Countdown
//
//  Created by Sebastian Livoni on 02/07/2022.
//

import SwiftUI

struct AddCountdownView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var viewContext
    
    @State var name: String = ""
    @State var description: String = ""
    @State var imageName: String = ""
    @State var endDate: Date = Date()
    @State var notificationEnabled: Bool = false
    
    func createCountdown() {
        let newCountdown = CountdownEntity(context: viewContext)
        newCountdown.id = UUID()
        newCountdown.name = name
        newCountdown.desc = description
        newCountdown.imageName = imageName
        
        if endDate > Date() {
            try? viewContext.save()
            dismiss()
        }
        // newCountdown.notificationEnabled = notificationEnabled
    }
 
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("INFORMATION ABOUT THE EVENT")) {
                        TextField("Name of event", text: $name)
                        
                        TextField("Description of event", text: $description)
                    }
                    
                    Section(header: Text("DECORATION")) {
                        TextField("What image do you want?", text: $imageName)
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
                    
                    Section {
                        Button("Create new countdown", action: createCountdown)
                    }
                }
            }
            
            .navigationTitle("Add Countdown")
            .navigationBarItems(
                trailing: Button {
                    dismiss()
                } label: {
                    Text("Dismiss")
                }
            )
        }
    }
}

struct AddCountdownView_Previews: PreviewProvider {
    static var previews: some View {
        AddCountdownView()
    }
}
