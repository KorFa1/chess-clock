//
//  TimerInitialText.swift
//  ChessClock
//
//  Created by Кирилл Софрин on 01.03.2023.
//

import Foundation

enum TimerInitial {
    case bullet
    case blitz
    case rapid
    case classic
    
    var text: String {
        switch self {
        case .bullet:
            return "1:00"
        case .blitz:
            return "3:00"
        case .rapid:
            return "10:00"
        case .classic:
            return "30:00"
        }
    }
}
  
