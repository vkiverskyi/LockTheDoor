//
//  MainScreenViewContoller.swift
//  LockTheDoor
//
//  Created by Vitalii Kiverskyi on 08.01.2023.
//

import SnapKit
import UIKit
/*
 In this class the main and additional instances of the main screen of the program are initialized and configured, namely:
 - image of the company logo
 - "settings" button
 - "password" button
 - label "greetings" (static)
 - "my door" verification type label (static)
 - table (cells are configured in the TableCellView.swift file)
 - view bottomFogEffectView (creates a "fog effect" at the bottom of the screen)
 
 Additional instances include:
 - loadedDoorData - received and decoded data (from the file data.json which is located in the root of the project)
 - timer, activityIndicator - instances of the UITimer and UIActivityIndicatorView classes, respectively,
   which help to simulate uploading data via API
 
 Constraints are set using SnapKit. Also some of the constraints were given according to iPhone SE 3rd screen size.
 */
class MainScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Instances
    private let settingsButton = UIButton()
    private let greetingsLabel = UILabel()
    private let typeOfVerificationLabel = UILabel()
    private let passwordButton = UIButton()
    private let tableView = UITableView()
    private var loadedDoorData: DoorData?
    private let timer = Timer()
    private var boolSwitcher = true
    private var doorStatusesEnum: DoorStatus?
    private let bottomFogEffectView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAllTheViews()
        //The animation simulates start uploading data via the API
        activityIndicator.startAnimating()
        /*
         Transfer data from the APIManager() to this controller and reload table data.
         Also stops simulates uploading data from the server via the API
         by stop animating activity indicator.
         */
         APIManager.shared.getDoorData { [weak self] data in
            guard let self else { return }
                self.loadedDoorData = data
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Setup all the views of this class
    private func setupAllTheViews() {
        setupCompanyLogo()
        setupSettingsButton()
        setupGreetingsLabel()
        setupHomeIcon()
        setupTypeOfVerificationLabel()
        setupTableView()
        setupBottomFogEffectView()
        setupPasswordButton()
        setupActivityIndicator()
    }
    
    //MARK: - setupActivityIndicator()
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.style = .medium
        activityIndicator.color = .systemBlue
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 180, left: 15, bottom: 0, right: 15))
        }
    }
    
    private func setupBottomFogEffectView() {
        self.view.addSubview(bottomFogEffectView)
        bottomFogEffectView.frame = CGRect(x: 0,
                                           y: view.frame.maxY,
                                           width: view.frame.size.width,
                                           height: -75)
        let gradient = CAGradientLayer()
        let whiteColor = UIColor.white
        gradient.frame = bottomFogEffectView.bounds
        gradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor,
                           whiteColor.withAlphaComponent(1.0).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.6)
        bottomFogEffectView.layer.addSublayer(gradient)
    }
    
    //MARK: - setupCompanyLogo()
    private func setupCompanyLogo() {
        let image = UIImageView(image: ImageConst.logoIcon)
        view.addSubview(image)
        image.snp.makeConstraints { make in
            // Better top position for company logo in iPhone SE 3rd
            if UIDevice().type == .iPhoneSE3 {
                make.top.equalToSuperview().inset(59)
            } else {
                make.top.equalToSuperview().inset(77)
            }
            make.left.equalToSuperview().inset(24)
        }
    }
    
    //MARK: - setupSettingsButton()
    private func setupSettingsButton() {
        view.addSubview(settingsButton)
        settingsButton.setImage(ImageConst.settingsIcon, for: .normal)
        settingsButton.snp.makeConstraints { make in
            // Better top position for setttings button in iPhone SE 3rd
            if UIDevice().type == .iPhoneSE3 {
                make.top.equalToSuperview().inset(45)
            } else {
                make.top.equalToSuperview().inset(63)
            }
            make.right.equalToSuperview().inset(27)
        }
    }
    
    //MARK: - setupGreetingsLabel()
    private func setupGreetingsLabel() {
        view.addSubview(greetingsLabel)
        greetingsLabel.text = TextLabelConst.greetings
        greetingsLabel.font = UIFont(name: FontConst.customFontBold, size: 35)
        greetingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(157)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    //MARK: - setupHomeIcon()
    private func setupHomeIcon() {
        let image = UIImageView(image: ImageConst.homeIcon)
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(108)
            make.right.equalToSuperview().inset(4)
        }
    }
    
    //MARK: - setupTypeOfVerificationLabel()
    private func setupTypeOfVerificationLabel() {
        view.addSubview(typeOfVerificationLabel)
        typeOfVerificationLabel.text = TextLabelConst.typeOfVerification
        typeOfVerificationLabel.font = UIFont(name: FontConst.customFontBold, size: 20)
        typeOfVerificationLabel.snp.makeConstraints { make in
            // Better top position for type of verif. label in iPhone SE 3rd
            if UIDevice().type == .iPhoneSE3 {
                make.top.equalToSuperview().inset(290)
            } else {
                make.top.equalToSuperview().inset(307)
            }
            make.left.equalToSuperview().inset(25)
        }
    }
    
    //MARK: - setupPasswordButton()
    private func setupPasswordButton() {
        view.addSubview(passwordButton)
        passwordButton.setImage(ImageConst.passwordIcon, for: .normal)
        passwordButton.backgroundColor = view.backgroundColor
        passwordButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(15)
            // Better right position for password button in iPhone SE 3rd
            if UIDevice().type == .iPhoneSE3 {
                make.right.equalToSuperview().inset(26)
            } else {
                make.right.equalToSuperview().inset(46)
            }
        }
    }
    
    // MARK: - setupTableView()
    let cellIdenifier = "lockControlCellIdentifier"
    
    private func setupTableView() {
        view.addSubview(tableView)
        setupTableViewConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 117
        tableView.separatorColor = .clear
        tableView.register(TableCellViewController.self, forCellReuseIdentifier: cellIdenifier)
    }
    
    private func setupTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            // Better edges for table view in iPhone SE 3rd
            if UIDevice().type == .iPhoneSE3 {
                make.edges.equalTo(UIEdgeInsets(top: 330, left: 16, bottom: 0, right: 15))
            } else {
                make.edges.equalTo(UIEdgeInsets(top: 360, left: 16, bottom: 13, right: 15))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return loadedDoorData?.data.count ?? 0
    }
    
    // Use empty view of header in section for adding space between sections
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdenifier) as! TableCellViewController
        let doorData = loadedDoorData!.data[indexPath.section]
        switch (doorData.statusLocked, boolSwitcher) {
        case (true, true):
            doorStatusesEnum = .locked
        case (false, true):
            doorStatusesEnum = .unlocked
            
        default: break
        }
        // Method which transfer data to TableCellViewController
        cell.setupTableCellViews(data: doorData, currentDoorStatus: doorStatusesEnum!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mockAPICall(tableView: tableView, indexPath: indexPath)
    }
    
    //MARK: - simulate API call
    /*
     This method simulates an API call. It is called after clicking on a table cell.
     Next, the position of the switcher (boolSwitcher) will change to the opposite.
     According to this, the cell takes the status of "unlocking" or "locking".
     After that, there is a delay with the help of a timer. And then the cell is assigned the "locked"/unlocked status.
     Updating the data in the cell is done using the reloadSections() method.
     */
    func mockAPICall(tableView: UITableView, indexPath: IndexPath) {
        /*
         This if/else is needed in the setupTableCellViews() method
         in order to set the necessary door parameters for the cell
         */
        if loadedDoorData!.data[indexPath.section].statusLocked {
            doorStatusesEnum = .unlocking
            boolSwitcher = !boolSwitcher
        } else {
            doorStatusesEnum = .locking
            boolSwitcher = !boolSwitcher
        }
        
        tableView.reloadSections([indexPath.section] , with: .fade)
        
        // This assignment simulates a "PUT" request, which should change the status of the door: locked/unlocked
        loadedDoorData!.data[indexPath.section].statusLocked = !loadedDoorData!.data[indexPath.section].statusLocked
        boolSwitcher = !boolSwitcher
        
        //The timer simulates the delay of the api call
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
            self.tableView.reloadSections([indexPath.section], with: .top)
        })
    }
}
