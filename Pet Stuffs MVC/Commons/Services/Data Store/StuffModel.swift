//
//  StuffModel.swift
//  Pet Stuffs MVC
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 26/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

struct StuffModel: Codable {

    static let dataKey = "stuff-model-key"

    let uuid: String = UUID().uuidString
    let petUuid: String
    let name: String
    let type: String
    let price: Double

    static func getAll() -> [StuffModel] {
        guard let stuffsData = UserDefaults.standard.data(forKey: StuffModel.dataKey) else { return [] }
        let stuffs = try? JSONDecoder().decode([StuffModel].self, from: stuffsData)
        return stuffs ?? []
    }

    static func get(with petUuid: String) -> [StuffModel] {
        let stuffsSerialized = UserDefaults.standard.array(forKey: StuffModel.dataKey)
        if let stuffs = stuffsSerialized as? [StuffModel] {
            return stuffs.filter { $0.petUuid == petUuid }
        } else {
            return []
        }
    }

    func saveOrUpdate() {
        var stuffs = StuffModel.getAll()

        if let stuffIndex = stuffs.firstIndex(where: { $0.uuid == self.uuid }) {
            stuffs[stuffIndex] = self
        } else {
            stuffs.append(self)
        }

        let stuffsEncoded = try? JSONEncoder().encode(stuffs)
        UserDefaults.standard.set(stuffsEncoded, forKey: StuffModel.dataKey)
    }

}
