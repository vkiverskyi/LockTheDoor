//
//  Images.swift
//  LockTheDoor
//
//  Created by Vitalii Kiverskyi on 12.01.2023.
//

import UIKit

struct ImageConst {
    static let logoIcon                     = UIImage(named: "ic-logoCompany")
    static let homeIcon                     = UIImage(named: "ic-home")
    static let settingsIcon                 = UIImage(named: "ic-settings")
    static let passwordIcon                 = UIImage(named: "ic-password")
    static let doorLockedIcon               = UIImage(named: "ic-cell-doorLocked")
    static let doorUnlockedIcon             = UIImage(named: "ic-cell-doorUnlocked")
    static let doorLoadingIcon              = UIImage(named: "ic-cell-doorLoading")
    static let securityActivatedIcon        = UIImage(named: "ic-cell-securityActivated")
    static let securityUnactivatedIcon      = UIImage(named: "ic-cell-securityUnactivated")
    static let securityLoadingIcon          = UIImage(named: "ic-cell-securityInstalling")
}

struct FontConst {
    static let customFontBold               = "Sk-Modernist-Bold"
    static let customFontRegular            = "Sk-Modernist-Regular"
    static let customFontMono               = "Sk-Modernist-Mono"
}

struct FontColorConst {
    static let lockingUnlockingDoorColor    = UIColor(red: 0, green: 0, blue: 0, alpha: 0.17)
    static let unlockedDoorColor            = UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 0.5)
    static let lockedDoorColor              = UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 1)
}

struct TextLabelConst {
    static let unlocking                    = "Unlocking..."
    static let locking                      = "Locking..."
    static let unlocked                     = "Unlocked"
    static let locked                       = "Locked"
    
    static let greetings                    = "Welcome"
    static let typeOfVerification           = "My doors"
    
    
}



