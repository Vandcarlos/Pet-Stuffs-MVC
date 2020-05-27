//
//  MainViewController.swift
//  Pet Stuffs MVC
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 26/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    private let reuseIdenfier = "MainPetCell"
    private var pets: [MainPet] = []

    override func viewDidAppear(_ animated: Bool) {
        self.getPetsOnDB()
        self.tableView.reloadData()
    }

    private func getPetsOnDB() {
        self.pets = PetModel.getAll().compactMap { MainPet(uuid: $0.uuid, name: $0.name) }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdenfier, for: indexPath)

        if let mainPetCell = cell as? MainPetCell {
            mainPetCell.petNameLabel.text = self.pets[indexPath.row].name
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

