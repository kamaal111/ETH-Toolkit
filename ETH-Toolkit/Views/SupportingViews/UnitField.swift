//
//  UnitField.swift
//  ETH-Toolkit
//
//  Created by Kamaal M Farah on 02/04/2023.
//

import SwiftUI
import SalmonUI

struct UnitField: View {
    @State private var valueIsValid = true

    @Binding var value: String

    let title: String

    var body: some View {
        VStack(alignment: .leading) {
            KTitledView(title: title) {
                HStack {
                    TextField("", text: $value)
                        .labelsHidden()
                    if !valueIsValid {
                        Button(action: fixValue) {
                            HStack(spacing: 0) {
                                Image(systemName: "hammer.fill")
                                #warning("Localize this")
                                Text("Fix")
                                    .textCase(.uppercase)
                            }
                            .foregroundColor(.accentColor)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            if !valueIsValid {
                #warning("Localize this")
                Text("Invalid value")
                    .font(.subheadline)
                    .foregroundColor(.red)
            }
        }
        .onChange(of: value, perform: handleValueChange)
    }

    private func fixValue() {
        guard !valueIsValid else { return }

        let sanitizedValue = value.sanitizedDouble
        value = String(sanitizedValue)
    }

    private func handleValueChange(_ newValue: String) {
        let doubleValue = Double(value)
        if valueIsValid != (doubleValue != nil) {
            withAnimation { valueIsValid = (doubleValue != nil) }
        }
    }
}

struct UnitField_Previews: PreviewProvider {
    static var previews: some View {
        UnitField(value: .constant(""), title: "Wei")
    }
}
