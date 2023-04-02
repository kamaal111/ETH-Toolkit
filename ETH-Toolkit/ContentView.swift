//
//  ContentView.swift
//  ETH-Toolkit
//
//  Created by Kamaal M Farah on 02/04/2023.
//

import SwiftUI
import BetterNavigation

struct ContentView: View {
    var body: some View {
        NavigationStackView(
            stack: [] as [Screens],
            root: { screen in MainView(screen: screen) },
            subView: { screen in MainView(screen: screen, displayMode: .inline) },
            sidebar: { Sidebar() })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
