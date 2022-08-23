//
//  Enum.swift
//  NFTViewer
//
//  Created by justyn on 2022-08-22.
//

import Foundation

public enum Speed: Double, CaseIterable {
    case slow = 1.0
    case normal = 0.5
    case fast = 0.25
    
    var stringRepresentation: String {
        switch self {
        case .slow: return ".slow"
        case .normal: return ".normal"
        case .fast: return ".fast"
        }
    }
}

public enum Size: CGFloat, CaseIterable {
    case small = 25
    case medium = 50
    case large = 100
    case extraLarge = 150
    
    var stringRepresentation: String {
        switch self {
        case .small: return ".small"
        case .medium: return ".medium"
        case .large: return ".large"
        case .extraLarge: return ".extraLarge"
        }
    }
}
