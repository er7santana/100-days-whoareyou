//
//  DetailView.swift
//  WhoAreYou
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import SwiftUI

struct DetailView: View {
    var person: Person
    
    var body: some View {
        VStack(spacing: 20) {
            person.image
                .resizable()
                .scaledToFit()
            
            Text(person.name)
        }
        .padding(.vertical)
    }
}

#Preview {
    DetailView(person: Person.exampleItem())
}
