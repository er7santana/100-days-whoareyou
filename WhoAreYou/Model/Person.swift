//
//  Person.swift
//  WhoAreYou
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import Foundation
import SwiftUI

struct Person: Codable, Identifiable, Hashable {
    var id = UUID()
    var name = ""
    var imageData = Data()
    
    var image: Image {
        if imageData.isEmpty == false, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }
        
        return Image(.example)
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
}

extension Person {
    static func exampleItem() -> Person {
        return Person(name: "Eliezer")
    }
    
    static func exampleItems() -> [Person] {
        return [
            Person(name: "Eliezer"),
            Person(name: "Rodrigo"),
            Person(name: "Shaft"),
            Person(name: "Eli"),
            Person(name: "Diguinho"),
            Person(name: "Negão"),
        ]
    }
}
