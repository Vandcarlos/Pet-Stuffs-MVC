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

    var uuid: String = UUID().uuidString
    var petUuid: String
    var name: String
    var type: String
    var price: Double

    static func getAll() -> [StuffModel] {
        guard let stuffsData = UserDefaults.standard.data(forKey: StuffModel.dataKey) else { return [] }
        let stuffs = try? JSONDecoder().decode([StuffModel].self, from: stuffsData)
        return stuffs ?? []
    }

    static func getAll(filterByPetUuid petUuid: String) -> [StuffModel] {
        guard let stuffsData = UserDefaults.standard.data(forKey: StuffModel.dataKey) else { return [] }
        if let stuffs = try? JSONDecoder().decode([StuffModel].self, from: stuffsData) {
            return stuffs.filter { $0.petUuid == petUuid }
        } else {
            return []
        }
    }

    static func get(byUuid uuid: String) -> StuffModel? {
        let stuffs = StuffModel.getAll()
        return stuffs.first(where: { $0.uuid == uuid })
    }

    static func delete(withUuid uuid: String) {
        var stuffs = StuffModel.getAll()

        if let index = stuffs.firstIndex(where: { $0.uuid == uuid }) {
            stuffs.remove(at: index)
        }

        let stuffsEncoded = try? JSONEncoder().encode(stuffs)
        UserDefaults.standard.set(stuffsEncoded, forKey: StuffModel.dataKey)
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
