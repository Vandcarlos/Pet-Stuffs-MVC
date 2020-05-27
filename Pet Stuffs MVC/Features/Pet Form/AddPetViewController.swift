//
//  AddPetViewController.swift
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

//    var

    private let errorMessage = """
    Verifique as condições
    O nome possuí no mínimo: \(PetValidation.minNameSize) caracteres
    O gênero possuí no mínimo: \(PetValidation.minGenderSize) caracteres
    A espécie possuí no mínimo: \(PetValidation.minSpecieSize) caracteres
    """

    private typealias PetFormInput = (String, String, String)

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let (name, gender, specie) = self.getValidForm() {
            self.savePet(name: name, gender: gender, specie: specie)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.showError()
        }
    }

    private func getValidForm() -> PetFormInput? {
        guard let name = self.getValidName(),
            let gender = self.getValidGender(),
            let specie = self.getValidSpecie()
            else { return nil }

        return PetFormInput(name, gender, specie)
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

    private func savePet(name: String, gender: String, specie: String) {
        PetModel(name: name, gender: gender, specie: specie).saveOrUpdate()
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
