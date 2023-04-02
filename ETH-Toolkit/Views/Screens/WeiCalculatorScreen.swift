//
//  WeiCalculatorScreen.swift
//  ETH-Toolkit
//
//  Created by Kamaal M Farah on 02/04/2023.
//

import SwiftUI
import SalmonUI

struct WeiCalculatorScreen: View {
    @StateObject private var viewModel = ViewModel()

    @FocusState private var focusedTextField: TextFields?

    var body: some View {
        KScrollableForm {
            VStack {
                #warning("Localize this")
                UnitField(value: $viewModel.weiValue, title: "Wei")
                    .focused($focusedTextField, equals: .wei)
                #warning("Localize this")
                UnitField(value: $viewModel.gweiValue, title: "Gwei")
                    .focused($focusedTextField, equals: .gwei)
                #warning("Localize this")
                UnitField(value: $viewModel.etherValue, title: "ETH")
                    .focused($focusedTextField, equals: .ether)
            }
            #if os(macOS)
            .padding(.horizontal, 16)
            #endif
        }
        .onChange(of: focusedTextField, perform: viewModel.onFocusedTextFieldChange)
    }
}

fileprivate enum TextFields {
    case wei
    case gwei
    case ether
}

extension WeiCalculatorScreen {
    final class ViewModel: ObservableObject {
        @Published var weiValue = "0" {
            didSet { Task { await weiValueDidSet() } }
        }
        @Published var gweiValue = "0" {
            didSet { Task { await gweiValueDidSet() } }
        }
        @Published var etherValue = "0" {
            didSet { Task { await etherValueDidSet() } }
        }

        private var focusedTextField: TextFields?

        init() { }

        fileprivate func onFocusedTextFieldChange(_ state: TextFields?) {
            focusedTextField = state
        }

        @MainActor
        private func setFieldValue(value: Double, field: TextFields) {
            let newValue =  "\(value)"
            switch field {
            case .wei:
                weiValue = newValue
            case .gwei:
                gweiValue = newValue
            case .ether:
                etherValue = newValue
            }
        }

        @MainActor
        private func resetFieldValues(fields: TextFields...) {
            for field in fields {
                setFieldValue(value: 0, field: field)
            }
        }

        private func weiValueDidSet() async {
            guard focusedTextField == .wei else { return }

            guard let weiValue = Double(weiValue) else {
                await resetFieldValues(fields: .gwei, .ether)
                return
            }

            async let gweiPromise: () = setFieldValue(value: weiValue / pow(10, 9), field: .gwei)
            async let etherPromise: () = setFieldValue(value: weiValue / pow(10, 18), field: .ether)
            _ = await [gweiPromise, etherPromise]
        }

        private func gweiValueDidSet() async {
            guard focusedTextField == .gwei else { return }

            guard let gweiValue = Double(gweiValue) else {
                await resetFieldValues(fields: .wei, .ether)
                return
            }

            async let weiPromise: () = setFieldValue(value: gweiValue * pow(10, 9), field: .wei)
            async let etherPromise: () = setFieldValue(value: gweiValue / pow(10, 9), field: .ether)
            _ = await [weiPromise, etherPromise]
        }

        private func etherValueDidSet() async {
            guard focusedTextField == .ether else { return }

            guard let etherValue = Double(etherValue) else {
                await resetFieldValues(fields: .wei, .gwei)
                return
            }

            async let weiPromise: () = setFieldValue(value: etherValue * pow(10, 18), field: .wei)
            async let gweiPromise: () = setFieldValue(value: etherValue * pow(10, 9), field: .gwei)
            _ = await [weiPromise, gweiPromise]
        }
    }
}

struct WeiCalculatorScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeiCalculatorScreen()
    }
}
