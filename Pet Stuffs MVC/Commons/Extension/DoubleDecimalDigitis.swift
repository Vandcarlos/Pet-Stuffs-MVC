//
//  DoubleDecimalDigitis.swift
//  Pet Stuffs MVC
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 09/06/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

extension Double {

    func decimalDigitsIsEqual(_ decimalDigits: Int) -> Bool {
        let valueToCompare = Double(String(format: "%.\(decimalDigits)f", self))!
        return valueToCompare == self
    }

}
