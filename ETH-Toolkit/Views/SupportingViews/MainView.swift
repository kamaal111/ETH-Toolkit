//
//  MainView.swift
//  ETH-Toolkit
//
//  Created by Kamaal M Farah on 02/04/2023.
//

import SwiftUI
import SalmonUI
import BetterNavigation

struct MainView: View {
    let screen: Screens
    let displayMode: DisplayMode

    init(screen: Screens, displayMode: DisplayMode = .large) {
        self.screen = screen
        self.displayMode = displayMode
    }


    var body: some View {
        KJustStack {
            switch screen {
            case .weiCalculator:
                WeiCalculatorScreen()
            }
        }
        .navigationTitle(title: screen.title, displayMode: displayMode)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(screen: .root)
    }
}
