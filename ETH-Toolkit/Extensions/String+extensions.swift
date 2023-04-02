//
//  String+extensions.swift
//  ETH-Toolkit
//
//  Created by Kamaal M Farah on 02/04/2023.
//

import Foundation

extension String {
    var sanitizedDouble: Double {
        let splittedString = self.split(separator: ".", omittingEmptySubsequences: false)
        guard !splittedString.isEmpty else { return 0 }

        var processedFirstComponent = splittedString[0].filter(\.isNumber)
        if processedFirstComponent.isEmpty {
            processedFirstComponent = "0"
        }
        var components = [processedFirstComponent]
        if splittedString.count > 1 {
            components.append(splittedString[1].filter(\.isNumber))
        }

        return Double(components.joined(separator: ".")) ?? 0
    }
}
