//
//  PetFormViewController.swift
//  Pet Stuffs MVC
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 26/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class PetFormViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var genderLabel: UITextField!
    @IBOutlet weak var specieLabel: UITextField!

    var petForm: PetForm?

    private let errorMessage = """
    Verifique as condições
    O nome possuí no mínimo: \(PetValidation.minNameSize) caracteres
    O gênero possuí no mínimo: \(PetValidation.minGenderSize) caracteres
    A espécie possuí no mínimo: \(PetValidation.minSpecieSize) caracteres
    """

    override func viewDidLoad() {
        if let petForm = self.petForm {
            self.fullFillForm(with: petForm)
            self.title = "Editar Pet"
        } else {
            self.title = "Adicionar Pet"
        }
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let petForm = self.getValidForm() {
            self.savePet(with: petForm)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.showError()
        }
    }

    private func fullFillForm(with petForm: PetForm) {
        self.nameLabel.text = petForm.name
        self.genderLabel.text = petForm.gender
        self.specieLabel.text = petForm.specie
    }

    private func getValidForm() -> PetForm? {
        guard let name = self.getValidName(),
            let gender = self.getValidGender(),
            let specie = self.getValidSpecie()
            else { return nil }

        return PetForm(uuid: self.petForm?.uuid, name: name, gender: gender, specie: specie)
    }

    private func getValidName() -> String? {
        if let name = nameLabel.text, name.count > PetValidation.minNameSize {
            return name
        } else {
            return nil
        }
    }

    private func getValidGender() -> String? {
        if let gender = genderLabel.text, gender.count > PetValidation.minGenderSize {
            return gender
        } else {
            return nil
        }
    }

    private func getValidSpecie() -> String? {
        if let specie = specieLabel.text, specie.count > PetValidation.minSpecieSize {
            return specie
        } else {
            return nil
        }
    }

    private func savePet(with petForm: PetForm) {
        if let uuid = petForm.uuid, var pet = PetModel.get(with: uuid) {
            pet.name = petForm.name
            pet.gender = petForm.gender
            pet.specie = petForm.specie
            pet.saveOrUpdate()
        } else {
            PetModel(name: petForm.name, gender: petForm.gender, specie: petForm.specie).saveOrUpdate()
        }
    }

    private func showError() {
        let alertController = UIAlertController(
            title: "Erro ao salvar",
            message: self.errorMessage,
            preferredStyle: .alert
        )

        let closeButton = UIAlertAction(title: "Fechar", style: .cancel)
        alertController.addAction(closeButton)
        self.present(alertController, animated: true)
    }
}
