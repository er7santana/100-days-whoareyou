//
//  PersonViewModel.swift
//  WhoAreYou
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import SwiftUI

extension ContentView {
    
    @Observable
    class ViewModel {
        var people: [Person] = []
        var path = [Person]()
        var showingAddPerson = false
        
        init() {
            
        }
        
        init(sampleData: [Person]) {
            people = sampleData
        }
        
        func loadData() {
            do {
                people = try FileManager.read()
            } catch {
                people = []
            }
        }
    }
    
}
