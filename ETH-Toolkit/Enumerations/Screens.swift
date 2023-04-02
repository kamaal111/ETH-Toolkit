//
//  Screens.swift
//  ETH-Toolkit
//
//  Created by Kamaal M Farah on 02/04/2023.
//

import Foundation
import BetterNavigation

enum Screens: Hashable, Codable, Identifiable, CaseIterable, NavigatorStackValue {
    case weiCalculator

    var id: UUID {
        switch self {
        case .weiCalculator:
            return UUID(uuidString: "79bf1864-e932-483b-b2dd-514aa068850b")!
        }
    }

    var isTabItem: Bool {
        switch self {
        case .weiCalculator:
            return true
        }
    }

    var isSidebarItem: Bool {
        switch self {
        case .weiCalculator:
            return true
        }
    }

    var imageSystemName: String {
        switch self {
        case .weiCalculator:
            return "flame"
        }
    }

    var title: String {
        switch self {
        case .weiCalculator:
            #warning("Localize")
            return "Wei calculator"
        }
    }

    static var root: Screens = .weiCalculator
}
