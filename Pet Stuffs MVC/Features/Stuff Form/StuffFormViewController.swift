//
//  StuffFormViewController.swift
//  Pet Stuffs MVC
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 27/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class StuffFormViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var typeLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!

    var petUuid: String!
    var stuff: StuffModel?

    private let priceDelegate = PriceDelagate()

    private let errorMessage = """
    Verifique as condições
    O nome possuí no mínimo: \(StuffValidation.minNameSize) caracteres
    O tipo possuí no mínimo: \(StuffValidation.minTypeSize) caracteres
    O preço é valido
    """

    override func viewDidLoad() {
        self.priceLabel.delegate = priceDelegate
        self.checkIfHasStuff()
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let stuffForm = self.getValidForm() {
            self.saveStuff(with: stuffForm)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.showError()
        }
    }

    private func checkIfHasStuff() {
        if let stuff = self.stuff {
            self.fullFillForm(with: stuff)
            self.title = "Editar Stuff"
        } else {
            self.title = "Adicionar Stuff"
        }
    }

    private func fullFillForm(with stuff: StuffModel) {
        self.nameLabel.text = stuff.name
        self.typeLabel.text = stuff.type
        self.priceLabel.text = String(format: "%.2f", stuff.price)
    }

    private func getValidForm() -> StuffForm? {
        guard let name = self.getValidName(),
            let type = self.getValidType(),
            let price = self.getValidPrice()
            else { return nil }

        return StuffForm(uuid: self.stuff?.uuid, petUuid: self.petUuid, name: name, type: type, price: price)
    }

    private func getValidName() -> String? {
        if let name = nameLabel.text, name.count > StuffValidation.minNameSize {
            return name
        } else {
            return nil
        }
    }

    private func getValidType() -> String? {
        if let type = typeLabel.text, type.count > StuffValidation.minTypeSize {
            return type
        } else {
            return nil
        }
    }

    private func getValidPrice() -> Double? {
        return priceLabel.text?.toDoubleWithLocale()
    }

    private func saveStuff(with stuffForm: StuffForm) {
        if let uuid = stuffForm.uuid, var stuff = StuffModel.get(byUuid: uuid) {
            stuff.name  = stuffForm.name
            stuff.type = stuffForm.type
            stuff.price = stuffForm.price
            stuff.saveOrUpdate()
        } else {
            let stuff = StuffModel(petUuid: self.petUuid, name: stuffForm.name, type: stuffForm.type, price: stuffForm.price)
            stuff.saveOrUpdate()
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
