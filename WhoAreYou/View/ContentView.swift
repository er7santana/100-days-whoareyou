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
                        Circle()
                            .fill(.white)
                            .frame(width: 43, height: 43)
                            .overlay {
                                person.image
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .scaledToFit()
                                    .clipShape(.circle)
                            }
                            .shadow(radius: 1)
                        
                        
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
            .sheet(isPresented: $viewModel.showingAddPerson, onDismiss: loadData) {
                NavigationStack {
                    AddPersonView()
                }
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
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
