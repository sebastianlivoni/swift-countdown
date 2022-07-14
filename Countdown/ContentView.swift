//
//  ContentView.swift
//  Countdown
//
//  Created by Sebastian Livoni on 01/07/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var countdowns: FetchedResults<CountdownEntity>
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var editMode = EditMode.inactive
    @State private var showingAddScreen = false
 
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(countdowns, id: \.id) { countdown in
                        NavigationLink {
                            DetailView(countdown: countdown)
                        } label: {
                            CountdownRow(countdown: countdown)
                        }
                    }
                    .onDelete(perform: delete)
                }
                            
                .navigationTitle("Countdowns")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Countdown", systemImage: "plus")
                    }
                )
                .environment(\.editMode, $editMode)
            }
            .sheet(isPresented: $showingAddScreen) {
                AddCountdownView()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.map { countdowns[$0] }.forEach(viewContext.delete)
        
        try? viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController()
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
