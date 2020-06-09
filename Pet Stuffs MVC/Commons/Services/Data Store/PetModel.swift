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

    var uuid: String = UUID().uuidString
    var name: String
    var gender: String
    var specie: String

    var stuffs: [StuffModel] {
        StuffModel.getAll(filterByPetUuid: self.uuid)
    }

    static func getAll() -> [PetModel] {
        guard let petsData = UserDefaults.standard.data(forKey: PetModel.dataKey) else { return [] }
        let pets = try? JSONDecoder().decode([PetModel].self, from: petsData)
        return pets ?? []
    }

    static func get(byUuid uuid: String) -> PetModel? {
        return self.getAll().first(where: { $0.uuid == uuid })
    }

    func saveOrUpdate() {
        var pets = PetModel.getAll()

        if let petIndex = pets.firstIndex(where: { $0.uuid == self.uuid }) {
            pets[petIndex] = self
        } else {
            pets.append(self)
        }

        let petsEncoded = try? JSONEncoder().encode(pets)
        UserDefaults.standard.set(petsEncoded, forKey: PetModel.dataKey)
    }

}
