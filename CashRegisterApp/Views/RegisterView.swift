//
//  ContentView.swift
//  CashRegisterApp
//
//  Created by Brian King on 4/11/24.
//

import SwiftUI

struct RegisterView: View {
    @State var purchasePrice: Double = 0.0
    @State var cashGiven: Double = 0.0
    @Environment(RegisterViewModel.self) var viewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ValueSlider(sliderTitle: "Purchase Price", valueReference: $purchasePrice)
                    .onChange(of: purchasePrice) {
                        viewModel.calculateChange(purchasePrice, cashGiven)
                    }
                .padding()
                .padding(.top, 40)
                Spacer()
                VStack(alignment: .center) {
                    Text(purchasePrice != 0.0 && cashGiven != 0.0 ? viewModel.changeDue : ChangeOutputs.NA.rawValue)
                        .font(.system(size: 40.0, weight: .heavy))
                        .multilineTextAlignment(.center )
                        .foregroundStyle(purchasePrice != 0.0 && cashGiven != 0.0 ?  viewModel.getColorCorrelation(for: viewModel.getChangeOutput()) : Color.softBlack)
                        .minimumScaleFactor(0.5)
                    Text("Change Due")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.softBlack)
                }
                Spacer()
                ValueSlider(sliderTitle: "Cash Given", valueReference: $cashGiven)
                    .onChange(of: cashGiven) {
                        viewModel.calculateChange(purchasePrice, cashGiven)
                    }
                .padding()
                Spacer()
            }
            .padding()
            .navigationTitle("Cash Register")
        }
    }
}

#Preview {
    RegisterView().environment(RegisterViewModel())
}

struct ValueSlider: View {
    
    let sliderTitle: String
    @Binding var valueReference: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(sliderTitle)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.softBlack)
                Spacer()
                Text("$\(NumberHelper().getRoundedNumberString(given: valueReference, by: 2))")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.softBlack)
            }
            Slider(value: $valueReference, in: 0...100.0)
        }
    }
}
