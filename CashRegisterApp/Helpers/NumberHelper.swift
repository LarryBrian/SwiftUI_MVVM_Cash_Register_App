//
//  NumberHelper.swift
//  CashRegisterApp
//
//  Created by Brian King on 4/12/24.
//

import Foundation

struct NumberHelper {
    func getRoundedNumberString(given number: Double, by numberOfDecimalPlaces: Int) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = numberOfDecimalPlaces
        nf.maximumFractionDigits = numberOfDecimalPlaces
        
        return nf.string(from: number as NSNumber) ?? ""
    }
}
