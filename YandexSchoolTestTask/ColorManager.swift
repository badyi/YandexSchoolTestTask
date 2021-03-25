//
//  ColorMannager.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 21.02.2021.
//

import UIKit

enum Theme: Int {
    case light, dark

    var mainColor: UIColor {
        switch self {
        case .light:
            return .white
        case .dark:
            return .black
        }
    }
    
    var firstCellBackgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor(hexString: "#F0F4F7")
        case .dark:
            return UIColor(hexString: "#F0F4F7")
        }
    }
    
    var secondCellBackgroundCOlo: UIColor {
        switch self {
        case .light:
            return .white
        case .dark:
            return .black
        }
    }
    
    var navBarBackgroundColor: UIColor {
        switch self {
        case .light:
            return .white
        case .dark:
            return .black
        }
    }
    
    var selectedButtonColo: UIColor {
        switch self {
        case .light:
            return UIColor(hexString: "#1A1A1A")
        case .dark:
            return .white
        }
    }
    
    var unselectedButtonColor: UIColor {
        return UIColor(hexString: "#BABABA")
    }
    
    var navBarTintColor: UIColor {
        switch self {
        case .light:
            return .white
        case .dark:
            return .black
        }
    }
    
    var textTintColor: UIColor {
        switch self {
        case .light:
            return .black
        case .dark:
            return .white
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .light:
            return .black
        case .dark:
            return .white
        }
    }
    
    var tintNotFavIconColor: UIColor {
        return .lightGray
    }
    
    var tintFavIconColor: UIColor {
        return .systemYellow
    }
}

let SelectedThemeKey = "SelectedTheme"

class ColorManager {
    static func currentStyle() -> Theme {
        return .light
    }
}
