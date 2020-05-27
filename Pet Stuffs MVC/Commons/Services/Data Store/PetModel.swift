//
//  PetModel.swift
//  Pet Stuffs MVC
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 26/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

struct PetModel: Codable {

    static let dataKey = "pet-model-key"

    let uuid = UUID()
    let name: String
    let gender: String
    let specie: String

    var stuffs: [StuffModel] {
        StuffModel.get(with: self.uuid)
    }

    static func getAll() -> [PetModel] {
        let petsSerialized = UserDefaults.standard.array(forKey: PetModel.dataKey)
        let pets = petsSerialized as? [PetModel]
        return pets ?? []
    }

    static func get(with uuid: UUID) -> PetModel? {
        return self.getAll().first(where: { $0.uuid == uuid })
    }

    func saveOrUpdate() {
        var pets = PetModel.getAll()

        if let petIndex = pets.firstIndex(where: { $0.uuid == self.uuid }) {
            pets[petIndex] = self
        } else {
            pets.append(self)
        }

        UserDefaults.standard.set(pets, forKey: PetModel.dataKey)
    }

}
