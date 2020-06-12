//
//  PetDetailsViewController.swift
//  Pet Stuffs MVC
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 27/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class PetDetailsViewController: UIViewController {

    private let reuseIdenfier = "StuffCell"

    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petGenderLabel: UILabel!
    @IBOutlet weak var petSpecieLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var pet: PetModel!

    private var stuffToEdit: StuffModel?

    private enum Segue: String {

        case toPetForm = "segueToPetForm"
        case toStuffForm = "segueToStuffForm"

    }

    override func viewWillAppear(_ animated: Bool) {
        self.checkForPetUpdates()
        self.fullFillPet()
        self.stuffToEdit = nil
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.toPetForm.rawValue: self.prepareSegueToPetForm(segue.destination)
        case Segue.toStuffForm.rawValue: self.prepareSegueToStuffForm(segue.destination)
        default: break
        }
    }

}

// MARK: Table view data source

extension PetDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pet.stuffs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdenfier, for: indexPath)

        if let petStuffCell = cell as? PetStuffCell {
            let petStuff = self.pet.stuffs[indexPath.row]
            petStuffCell.stuffNameLabel.text = petStuff.name
            petStuffCell.stuffTypeLabel.text = "Tipo: \(petStuff.type)"

            let price = String(format: "%.2f", petStuff.price)
            petStuffCell.stuffPriceLabel.text = "Preço: R$ \(price)"
        }

        return cell
    }

}

// MARK: Table view delegate

extension PetDetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.stuffToEdit = self.pet.stuffs[indexPath.row]
        self.performSegue(withIdentifier: Segue.toStuffForm.rawValue, sender: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let stuff = self.pet.stuffs[indexPath.row]
            StuffModel.delete(withUuid: stuff.uuid)
            self.checkForPetUpdates()
            self.tableView.reloadData()
        }
    }

}

// MARK: Private methods

extension PetDetailsViewController {

    private func prepareSegueToPetForm(_ viewController: UIViewController) {
        guard let petForm = viewController as? PetFormViewController else { return }
        petForm.pet = self.pet
    }

    private func prepareSegueToStuffForm(_ viewController: UIViewController) {
        guard let stuffForm = viewController as? StuffFormViewController else { return }
        stuffForm.petUuid = self.pet.uuid
        stuffForm.stuff = self.stuffToEdit
    }

    private func fullFillPet() {
        self.petNameLabel.text = pet.name
        self.petGenderLabel.text = "Gênero: \(pet.gender)"
        self.petSpecieLabel.text = "Espécie: \(pet.specie)"
    }

    private func checkForPetUpdates() {
        self.pet = PetModel.get(byUuid: self.pet.uuid)
    }

}
