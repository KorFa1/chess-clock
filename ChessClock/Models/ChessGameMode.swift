//
//  TimeValue.swift
//  ChessClock
//
//  Created by Кирилл Софрин on 01.03.2023.
//

import Foundation

enum ChessGame {
    case bullet
    case blitz
    case rapid
    case classic
    
    var mode: Int {
        switch self {
        case .bullet:
            return 60000
        case .blitz:
            return 180000
        case .rapid:
            return 600000
        case .classic:
            return 1800000
        }
    }
}
