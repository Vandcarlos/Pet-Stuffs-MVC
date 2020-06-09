//
//  StringToNumber.swift
//  Pet Stuffs MVC
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 09/06/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

extension String {

    func toDoubleWithLocale(_ locale: Locale = Locale.current) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = locale
        return numberFormatter.number(from: self)?.doubleValue
    }

}
