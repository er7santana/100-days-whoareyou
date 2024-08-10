//
//  AddPersonViewModel.swift
//  WhoAreYou
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import Foundation

extension AddPersonView {
    
    @Observable
    class ViewModel {
        var people: [Person]
        var imageData = Data()
        var name = ""
        var isSaveButtonDisabled: Bool {
            return name.isEmpty || imageData.isEmpty
        }
        
        init() {
            do {
                people = try FileManager.read()
            } catch {
                people = []
            }
        }
        
        func save() {
            do {
                try FileManager.write(content: people)
            } catch {
                print("Unable to save data")
            }
        }
        
        func addPerson() {
            let newPerson = Person(name: name, imageData: imageData)
            people.append(newPerson)
            save()
        }
    }
}
