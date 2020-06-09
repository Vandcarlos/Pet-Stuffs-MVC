//
//  PriceDelegate.swift
//  Pet Stuffs MVC
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 09/06/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class PriceDelagate: NSObject, UITextFieldDelegate {

    func textField(
         _ textField: UITextField,
         shouldChangeCharactersIn range: NSRange,
         replacementString string: String
     ) -> Bool {
        guard let text = textField.text else { return false }

        let newText = text + string

        guard let price = newText.toDoubleWithLocale() else { return false }

        return price.decimalDigitsIsEqual(2)
    }

}
