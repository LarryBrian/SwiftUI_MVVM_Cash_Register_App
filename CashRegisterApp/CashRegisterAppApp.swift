//
//  CashRegisterAppApp.swift
//  CashRegisterApp
//
//  Created by Brian King on 4/11/24.
//

import SwiftUI

@main
struct CashRegisterAppApp: App {
    var body: some Scene {
        WindowGroup {
            RegisterView()
                .environment(RegisterViewModel())
        }
    }
}
