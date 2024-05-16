//
//  ContentView.swift
//  Tip
//
//  Created by Dillon Teakell on 4/4/24.
//

import SwiftUI

struct ContentView: View {
    
    // Check amount and tip percentages properties
    @State private var checkAmount: Double = 0.0
    @State private var tipPercentage: Int = 20
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    
    // Computed Properties
    var totalTipped: Double {
        let tipAmount = Double(tipPercentage)
        let tipTotal = checkAmount / 100 * tipAmount
        return tipTotal
    }
    var totalWithTip: Double {
        let tipAmount = Double(tipPercentage)
        let tipTotal = checkAmount / 100 * tipAmount
        let grandTotal = checkAmount + tipTotal
        return grandTotal
    }
    
    // Custom modifier for currency code
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    // FocusState property to return the keyboard
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                // Check Amount
                Section ("Enter Check Amount") {
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: currencyCode))
                        .focused($isFocused)
                        .keyboardType(.decimalPad)
                        
                }
                
                // Tip Percentage Selection
                Section("Enter Tip Percentage") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { tip in
                            Text(tip, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                // Amount Tipped & Total After Tip
                Section ("Total") {
                    HStack {
                        Text("Amount Tipped")
                        Spacer()
                        Text(totalTipped, format: .currency(code: currencyCode))
                            .foregroundStyle(.gray)
                    }
                    
                    HStack {
                        Text("Check Total")
                        Spacer()
                        Text(totalWithTip, format: .currency(code: currencyCode))
                            .foregroundStyle(tipPercentage == 0 ? .red : .green)
                    }
                }
            }
            .navigationTitle("Tip Calculator")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    if isFocused {
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
