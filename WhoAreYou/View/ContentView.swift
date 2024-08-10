//
//  ContentView.swift
//  WhoAreYou
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewModel: ViewModel
    
    init(viewModel: ViewModel = ViewModel()) {
        self._viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            List(viewModel.people.sorted()) { person in
                NavigationLink(value: person) {
                    HStack {
                        person.image
                            .resizable()
                            .frame(width: 80, height: 80)
                            .scaledToFit()
                            .clipShape(.circle)
                        
                        Text(person.name)
                    }
                }
            }
            .navigationTitle("Contacts")
            .navigationDestination(for: Person.self, destination: { person in
                DetailView(person: person)
            })
            .toolbar {
                Button("Add person", systemImage: "plus") {
                    viewModel.showingAddPerson = true
                }
            }
            .sheet(isPresented: $viewModel.showingAddPerson) {
                NavigationStack {
                    AddPersonView(onSavedItem: onSavedData)
                }
            }
        }
    }
    
    func onSavedData() {
        viewModel.loadData()
    }
}

#Preview("Default") {
    return ContentView()
}

#Preview("With Sample") {
    let viewModel = ContentView.ViewModel(sampleData: Person.exampleItems())
    return ContentView(viewModel: viewModel)
}
