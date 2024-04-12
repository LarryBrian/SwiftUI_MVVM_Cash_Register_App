//
//  RegisterViewModel.swift
//  CashRegisterApp
//
//  Created by Brian King on 4/11/24.
//

import Foundation
import SwiftUI

@Observable class RegisterViewModel {
        
    // MARK: - VARIABLES
    var changeDue: String = ""
    
    // MARK: - FUNCTIONS
    func calculateChange(_ purchasePrice: Double, _ cashGiven: Double) {
        
        // List all currency values in array in Tuple (String, Double) format
        let currencyValues: [(String, Double)] = [("ONE HUNDRED", 100.00), ("FIFTY", 50.00), ("TWENTY", 20.00), ("TEN", 10.00), ("FIVE", 5.00), ("TWO", 2.00), ("ONE", 1.00), ("HALF DOLLAR", 0.50), ("QUARTER", 0.25), ("DIME", 0.10), ("NICKEL", 0.05), ("PENNY", 0.01)]
                
        let purchasePriceDecimal: Decimal = NSNumber(floatLiteral: purchasePrice).decimalValue
        let cashGivenDecimal: Decimal = NSNumber(floatLiteral: cashGiven).decimalValue
        
        var changeAmount = cashGivenDecimal - purchasePriceDecimal
        var changeDictionary = [String: Int]()
        
        if changeAmount < 0 {
            // if change amount is less than purchase price, return INSUFFICIENT
            changeDue = ChangeOutputs.Insufficient.rawValue
        } else if changeAmount == 0 {
            // if change amount is 0, return ZERO
            changeDue = ChangeOutputs.Zero.rawValue
        } else {
            // Loop through array currency array and extract out the count of each needed into new dictionary
            for (currency, value) in currencyValues {
                while changeAmount >= NSNumber(floatLiteral: value).decimalValue {
                    print("change amount: \(changeAmount), value: \(value)")
                    changeAmount = changeAmount - NSNumber(floatLiteral: value).decimalValue
                    
                    print("change amount: \(changeAmount)")
                    changeDictionary[currency, default: 0] += 1
                }
            }
            
            var result = ""
            
            // Sort currency needed alphabetically and loop through adding to result string until the count is 0
            for (currency, count) in changeDictionary.sorted(by: { $0.0 < $1.0 }) {
                if count > 0 {
                    result += "\(currency): \(count) \n"
                }
            }

            changeDue = result
        }
    }
    
    func getColorCorrelation(for changeDue: ChangeOutputs) -> Color {
        switch changeDue {
        case .Insufficient:
            return .red
        case .Positive:
            return .green
        case .Zero:
            return .yellow
        case .NA:
            return Color(.softBlack)
        }
    }
    
    func getChangeOutput() -> ChangeOutputs {
        guard changeDue != "" else { return .Zero }
                
        switch changeDue {
        case "Insufficient Funds":
            return .Insufficient
        case "Zero":
            return .Zero
        case "N/A":
            return .NA
        default:
            return .Positive
        }
    }
}
