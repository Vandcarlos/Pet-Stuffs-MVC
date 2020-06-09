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

    private var pets: [PetModel] = []
    private var petToShow: PetModel?

    private enum Segue: String {

        case toPetForm = "segueToPetForm"
        case toPetDetails = "segueToPetDetails"

    }

    override func viewDidAppear(_ animated: Bool) {
        self.petToShow = nil
        self.getPetsOnDB()
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.toPetForm.rawValue: break
        case Segue.toPetDetails.rawValue: self.prepareForSegueToPetDetails(segue.destination)
        default: break
        }
    }

}

// MARK: Table view data source

extension MainViewController {

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

}

// MARK: Table view delegate

extension MainViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.petToShow = self.pets[indexPath.row]
        self.performSegue(withIdentifier: Segue.toPetDetails.rawValue, sender: self)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pet = self.pets[indexPath.row]
            PetModel.delete(withUuid: pet.uuid)
            self.getPetsOnDB()
            self.tableView.reloadData()
        }
    }

}

// MARK: Private methods

extension MainViewController {

    private func getPetsOnDB() {
        self.pets = PetModel.getAll()
    }

    private func prepareForSegueToPetDetails(_ viewController: UIViewController) {
        guard let petDetails = viewController as? PetDetailsViewController else { return }
        guard let pet = self.petToShow else { return }
        petDetails.pet = pet
    }

}
