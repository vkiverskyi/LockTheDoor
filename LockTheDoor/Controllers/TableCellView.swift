//
//  TableCellView.swift
//  LockTheDoor
//
//  Created by Vitalii Kiverskyi on 12.01.2023.
//

import SnapKit
import UIKit
/*
 In this class initializes and configures table view cell instances, namely:
 - security status icons: activated/deactivated
 - door status icons: open/closed
 - door name
 - location of the door
 - door opening/closed button
 
setupDoorCellWithData() method is responsible for filling the cell with data
chooseAndSetupDoorCellToTable() method is responsible for which cell will be set in the table according to its status
Constraints are set using SnapKit.
 
 P.S.
 According to the task, I needed to configure the "Locked/Unlocked" button separately, but I failed.
 */
class TableCellView: UITableViewCell {
    
    // MARK: - Instances
    var securityStatusIcon = UIImageView()
    var doorStatusIcon = UIImageView()
    var doorName = UILabel()
    var doorLocationName = UILabel()
    let didTapLockUnlockButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAllTheViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup all the views of this class
    private func setupAllTheViews() {
        setupMainView()
        setupSecurityStatusIcon()
        setupDoorStatusIcon()
        setupDoorName()
        setupDoorLocationName()
        setupDidTapLockUnlockButton()
    }
    
    
    private func setupMainView() {
        layer.cornerRadius = 15.0
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.89, green: 0.918, blue: 0.918, alpha: 1).cgColor
    }
    
    private func setupSecurityStatusIcon() {
        addSubview(securityStatusIcon)
        securityStatusIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.left.equalToSuperview().inset(27)
        }
    }
    
    private func setupDoorStatusIcon() {
        addSubview(doorStatusIcon)
        doorStatusIcon.snp.makeConstraints { make in
            if doorStatusIcon.image == Images.doorLoadingIcon {
                make.top.equalToSuperview().inset(30)
                make.right.equalToSuperview().inset(50)
            
            } else {
                make.top.equalToSuperview().inset(22)
                make.right.equalToSuperview().inset(20)
            }
        }
    }
    
    private func setupDoorName() {
        addSubview(doorName)
        doorName.font = UIFont(name: Fonts.customFontBold, size: 16)
        doorName.textColor = UIColor(red: 0.196, green: 0.216, blue: 0.333, alpha: 1)
        doorName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(82)
        }
    }
    
    private func setupDoorLocationName() {
        addSubview(doorLocationName)
        doorLocationName.textColor = UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
        doorLocationName.font = UIFont(name: Fonts.customFontRegular, size: 14)
        doorLocationName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(41)
            make.left.equalToSuperview().inset(82)
        }
    }
    
    private func setupDidTapLockUnlockButton() {
        addSubview(didTapLockUnlockButton)
        didTapLockUnlockButton.titleLabel?.font = UIFont(name: Fonts.customFontBold, size: 15)
        didTapLockUnlockButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(85)
        }
    }
    
    //MARK: - Setup cell with received data
    enum DoorStatuses {
        case locking
        case unlocking
        case locked
        case unlocked
    }
    
    //This method is responsible for which cell will be set in the table according to its status
    func chooseAndSetupDoorCellToTable(cell: DoorDataItems, checkSwitcher: Bool, currentDoorStatus: Bool) {
        //The data about the names and location of the doors are assigned directly from the data from the server
        doorName.text = cell.doorName
        doorLocationName.text = cell.doorLocationName
        
        switch (checkSwitcher, currentDoorStatus) {
        case (true, true): setupDoorCellWithData(status: .unlocking)
        case (true, false): setupDoorCellWithData(status: .locking)
        case (false, true): setupDoorCellWithData(status: .locked)
        case (false, false): setupDoorCellWithData(status: .unlocked)
        }
    }
    
    //This method is responsible for filling the cell with data
    private func setupDoorCellWithData(status: DoorStatuses) {
        securityStatusIcon.image = Images.securityInstallingIcon
        doorStatusIcon.image = Images.doorLoadingIcon
        switch status {
        //In this switch parameters are the same for doors with two different statuses
        case .locking, .unlocking:
            securityStatusIcon.image = Images.securityInstallingIcon
            doorStatusIcon.image = Images.doorLoadingIcon
            didTapLockUnlockButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.17), for: .normal)
        case .locked, .unlocked:
            didTapLockUnlockButton.setTitleColor(UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 0.5), for: .normal)
        }
        //And this switch parameters are different for each status separately
        switch status {
        case .unlocking:
            didTapLockUnlockButton.setTitle("Unlocking...", for: .normal)
        case .locking:
            didTapLockUnlockButton.setTitle("Locking...", for: .normal)
        case .locked:
            didTapLockUnlockButton.setTitle("Locked", for: .normal)
            securityStatusIcon.image = Images.securityActivatedIcon
            doorStatusIcon.image = Images.doorLockedIcon
        case .unlocked:
            didTapLockUnlockButton.setTitle("Unlocked", for: .normal)
            securityStatusIcon.image = Images.securityUnactivatedIcon
            doorStatusIcon.image = Images.doorUnlockedIcon
        }
    }
}
