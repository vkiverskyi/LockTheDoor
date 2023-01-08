//
//  CustomCell.swift
//  LockTheDoor
//
//  Created by Vitalii Kiverskyi on 12.01.2023.
//

import UIKit

class CustomCell: UITableViewCell {
    
    func customCell(cell: inout UITableViewCell, for indexPath: IndexPath) {
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 0.89, green: 0.918, blue: 0.918, alpha: 1).cgColor
        
        let mainLabel = UILabel()
        mainLabel.text = "Front door"
        mainLabel.font = UIFont(name: Fonts.customFontBold, size: 16)
        mainLabel.textColor = UIColor(red: 0.196, green: 0.216, blue: 0.333, alpha: 1)
        cell.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(cell).inset(22)
            make.left.equalTo(cell).inset(82)
        }
        
        let secondaryLabel = UILabel()
        secondaryLabel.text = "Home"
        secondaryLabel.textColor = UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
        secondaryLabel.font = UIFont(name: Fonts.customFontRegular, size: 14)
        cell.addSubview(secondaryLabel)
        secondaryLabel.snp.makeConstraints { make in
            make.top.equalTo(cell).inset(41)
            make.left.equalTo(cell).inset(82)
        }
        
        let didTapLockUnlockButton = UIButton(type: .custom)
        didTapLockUnlockButton.setTitle("Locked", for: .normal)
        didTapLockUnlockButton.setTitleColor(UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 1), for: .normal)
        didTapLockUnlockButton.titleLabel?.font = UIFont(name: Fonts.customFontBold, size: 15)
        cell.addSubview(didTapLockUnlockButton)
        didTapLockUnlockButton.snp.makeConstraints { make in
            make.centerX.equalTo(cell)
            make.top.equalTo(cell).inset(85)
        }
        
        let securityStatusIcon = UIImageView(image: Images.securityActivatedIcon)
        cell.addSubview(securityStatusIcon)
        securityStatusIcon.snp.makeConstraints { make in
            make.top.equalTo(cell).inset(18)
            make.left.equalTo(cell).inset(27)
        }
        
        let doorStatusIcon = UIImageView(image: Images.doorLockedIcon)
        cell.addSubview(doorStatusIcon)
        doorStatusIcon.snp.makeConstraints { make in
            make.top.equalTo(cell).inset(18)
            make.right.equalTo(cell).inset(28)
        }
    }
}
