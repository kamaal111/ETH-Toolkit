//
//  Sidebar.swift
//  ETH-Toolkit
//
//  Created by Kamaal M Farah on 02/04/2023.
//

import SwiftUI
import BetterNavigation

struct Sidebar: View {
    var body: some View {
        List {
            #warning("Localize this")
            Section("Scenes") {
                ForEach(Screens.allCases.filter(\.isSidebarItem), id: \.self) { screen in
                    StackNavigationChangeStackButton(destination: screen) {
                        Label(screen.title, systemImage: screen.imageSystemName)
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        #if os(macOS)
        .toolbar(content: {
            Button(action: toggleSidebar) {
                #warning("Localize this")
                Label("Toggle sidebar", systemImage: "sidebar.left")
                    .foregroundColor(.accentColor)
            }
        })
        #endif
    }

    #if os(macOS)
    private func toggleSidebar() {
        guard let firstResponder = NSApp.keyWindow?.firstResponder else { return }
        firstResponder.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    #endif
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
