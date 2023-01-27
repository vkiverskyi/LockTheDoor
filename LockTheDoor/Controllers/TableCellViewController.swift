//
//  TableCellViewController.swift
//  LockTheDoor
//
//  Created by Vitalii Kiverskyi on 12.01.2023.
//
import SnapKit
import UIKit
/*
 In this class initializes and configures table view cell instances, namely:
 - security status icons: activated/deactivated
 - door status icons: locked/unlocked
 - door name
 - location of the door
 - door opening/closed button
 
setupTableCellViews() method is responsible for filling the cell with data.
Constraints are set using SnapKit.
P.S.
According to the task, I needed to configure the "Locked/Unlocked" button separately, but I failed.
 */

class TableCellViewController: UITableViewCell {
    
    // MARK: - Instances
    private let securityStatusIcon = UIImageView()
    private let doorStatusIcon = UIImageView()
    private let doorName = UILabel()
    private let doorLocationName = UILabel()
    private let didTapLockUnlockButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup all the views of this class
    func setupTableCellViews(data: DoorDataItems, currentDoorStatus: DoorStatus) {
        setupMainView()
        setupSecurityStatusIcon(status: currentDoorStatus)
        setupDoorStatusIcon(status: currentDoorStatus)
        setupDoorName(data: data)
        setupDoorLocationName(data: data)
        setupDidTapLockUnlockButton(status: currentDoorStatus)
    }
    
    //MARK: - setupMainView()
    private func setupMainView() {
        layer.cornerRadius = 15.0
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.89, green: 0.918, blue: 0.918, alpha: 1).cgColor
    }
    
    //MARK: - setupSecurityStatusIcon()
    private func setupSecurityStatusIcon(status: DoorStatus) {
        addSubview(securityStatusIcon)
        switch status {
        case .locking, .unlocking:
            securityStatusIcon.image = ImageConst.securityLoadingIcon
        case .locked:
            securityStatusIcon.image = ImageConst.securityActivatedIcon
        case .unlocked:
            securityStatusIcon.image = ImageConst.securityUnactivatedIcon
        }
        securityStatusIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.left.equalToSuperview().inset(27)
        }
    }
    
    //MARK: - setupDoorStatusIcon()
    private func setupDoorStatusIcon(status: DoorStatus) {
        addSubview(doorStatusIcon)
        switch status {
        case .locking, .unlocking:
            doorStatusIcon.image = ImageConst.doorLoadingIcon
        case .locked:
            doorStatusIcon.image = ImageConst.doorLockedIcon
        case .unlocked:
            doorStatusIcon.image = ImageConst.doorUnlockedIcon
        }
        doorStatusIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - setupDoorName()
    private func setupDoorName(data: DoorDataItems) {
        addSubview(doorName)
        doorName.text = data.doorName
        doorName.font = UIFont(name: FontConst.customFontBold, size: 16)
        doorName.textColor = UIColor(red: 0.196, green: 0.216, blue: 0.333, alpha: 1)
        doorName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(82)
        }
    }
    
    //MARK: - setupDoorLocationName()
    private func setupDoorLocationName(data: DoorDataItems) {
        addSubview(doorLocationName)
        doorLocationName.text = data.doorLocationName
        doorLocationName.textColor = UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
        doorLocationName.font = UIFont(name: FontConst.customFontRegular, size: 14)
        doorLocationName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(41)
            make.left.equalToSuperview().inset(82)
        }
    }
    
    //MARK: - setupDidTapLockUnlockButton()
    private func setupDidTapLockUnlockButton(status: DoorStatus) {
        contentView.addSubview(didTapLockUnlockButton)
        didTapLockUnlockButton.titleLabel?.font = UIFont(name: FontConst.customFontBold, size: 15)
        switch status {
        case .locking:
            didTapLockUnlockButton.setTitle(TextLabelConst.locking, for: .normal)
            didTapLockUnlockButton.setTitleColor(FontColorConst.lockingUnlockingDoorColor, for: .normal)
        case .unlocking:
            didTapLockUnlockButton.setTitle(TextLabelConst.unlocking, for: .normal)
            didTapLockUnlockButton.setTitleColor(FontColorConst.lockingUnlockingDoorColor, for: .normal)
        case .locked:
            didTapLockUnlockButton.setTitle(TextLabelConst.locked, for: .normal)
            didTapLockUnlockButton.setTitleColor(FontColorConst.lockedDoorColor, for: .normal)
        case .unlocked:
            didTapLockUnlockButton.setTitle(TextLabelConst.unlocked, for: .normal)
            didTapLockUnlockButton.setTitleColor(FontColorConst.unlockedDoorColor, for: .normal)
        }
        didTapLockUnlockButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(85)
        }
    }
}
