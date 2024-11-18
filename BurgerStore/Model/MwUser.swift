//
//  MwUser.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 30/01/2024.
//

import Foundation

struct MwUser: Identifiable, Codable {
    let id: String
    var fullName: String
    var phone: String
    var adress: String
    var city: String
    var numberHome: String
     
    var representation: [String: Any] {
        var repses = [String: Any]()
        repses["id"] = self.id
        repses["fullName"] = self.fullName
        repses["phone"] = self.phone
        repses["city"] = self.adress
        repses["adress"] = self.adress
        repses["numberHome"] = self.numberHome
        return repses
    }
}
