//
//  Resources.swift
//  InterQR
//
//  Created by Илья Мишин on 08.09.2022.
//

import UIKit

enum Resources {
    enum Colors {
        static var inter = UIColor(hexString: "#A7A8AA")
        static var myDoors = UIColor(hexString: "#323755")
        static var cellBorder = UIColor(hexString: "#E3EAEA")
        static var description = UIColor(hexString: "#B9B9B9")
        static var locked = UIColor(hexString: "#00448B")
        static var unlocking = UIColor(red: 0, green: 0, blue: 0, alpha: 0.17)
        static var unlocked = UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 0.5)
    }
    
    enum Strings {
        static var inter = "InterQR"
        static var welcome = "Welcome"
        static var myDoors = "My doors"
        static var cellTitle = "Front door"
        static var cellDescription = "Home"
        static var locked = "Locked"
        static var unlocking = "Unlocking..."
        static var unlocked = "Unlocked"
    }
    
    enum Images {
        static var settingsButton = UIImage(named: "SettingsButton")
        static var home = UIImage(named: "Home")
        static var iconCellLocked = UIImage(named: "IconLocked")
        static var doorIconLocked = UIImage(named: "DoorLocked")
        static var waitIcon = UIImage(named: "WaitIcon")
        static var doorIconUnlocked = UIImage(named: "DoorUnlocked")
        static var iconCellUnlocked = UIImage(named: "IconUnlocked")
    }
    
    enum Fonts {
        static func skModernistBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Sk-Modernist-Bold", size: size) ?? UIFont()
        }
    }
}

