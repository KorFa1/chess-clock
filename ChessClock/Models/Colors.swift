//
//  Colors.swift
//  ChessClock
//
//  Created by Кирилл Софрин on 28.02.2023.
//

import UIKit

 enum Color {
    case blue
    case lightGrey
    case darkGrey
    case red
    
    var color: UIColor {
        switch self {
        case .blue:
            return UIColor(red: 12/255, green: 93/255, blue: 151/255, alpha: 1)
        case .lightGrey:
            return UIColor(red: 106/255, green: 106/255, blue: 106/255, alpha: 1)
        case .darkGrey:
            return UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        case .red:
            return UIColor(red: 230/255, green: 11/255, blue: 13/255, alpha: 1)
        }
    }
}
