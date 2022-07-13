//
//  CountdownList.swift
//  Countdown
//
//  Created by Sebastian Livoni on 02/07/2022.
//

import SwiftUI

struct CountdownList: View {
    @State private var showAddCountdown = false
    @State var activeSheet: Countdown?
    
    @ObservedObject var model: Model
    
    func add() {       
        showAddCountdown.toggle()
    }
    
    func sp() {}
    
    func lol() {
        
    }
    
    func deleteItem(at offsets: IndexSet) {
        model.countdowns.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.countdowns, id: \.id) { countdown in
                    NavigationLink {
                        CountdownView(countdown: countdown, model: model)
                    } label: {
                        CountdownRow(countdown: countdown)
                    }
                }
                .onDelete(perform: deleteItem)
                /*.swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button {
                        activeSheet = countdown
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.gray)
                }*/
            }
                        
            .navigationTitle("Countdowns")
            .navigationBarItems(
                leading: Button(action: sp) {
                    // Delete & reorganize countdowns
                    Image(systemName: "ellipsis.circle")
                },
                trailing: Button(action: add) {
                    // Add new countdown
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showAddCountdown) {
            AddCountdown(model: model)
        }
        .sheet(item: $activeSheet) { item in
            EditCountdown(countdown: item, model: model)
        }
    }
}

struct CountdownList_Previews: PreviewProvider {
    static var previews: some View {
        CountdownList(model: Model())
    }
}
