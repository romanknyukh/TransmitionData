//
//  ViewController.swift
//  TransmitionData
//
//  Created by Roman Kniukh on 16.03.21.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var hidenLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(
                                                self.sendDataWithObserver(notification:)
                                                ),
                                               name: .userDataWasUpdated,
                                               object: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if let statusVC = UIStoryboard(name: "Status",
                                       bundle: nil).instantiateViewController(
                                        identifier: "StatusViewController"
                                       ) as? StatusViewController {
            
            guard self.usernameTextField.text?.isEmpty != true,
                  self.userPasswordTextField.text?.isEmpty != true else {
                return AlertHelper.shared.show(for: self,
                                               title: "Empty user data",
                                               message: "Please, enter your name and password",
                                               rightBittonTitle: "Ok",
                                               actionStyle: .default,
                                               rightBittonAction: nil) }
            
            statusVC.modalPresentationStyle = .fullScreen
            
            statusVC.usernameText = self.usernameTextField.text
            
            if let password = self.userPasswordTextField.text {
                statusVC.setPassword(password: password)
            }
            
            statusVC.delegate = self
            
            statusVC.action = { [weak self] status, name in
                guard let self = self else { return }
                self.hidenLabel.isHidden = false
                switch status {
                case .confirmed:
                    self.hidenLabel.text = "Velcome \(name)!"
                    self.hidenLabel.tintColor = .blue
                default:
                    self.hidenLabel.text = "Error"
                    self.hidenLabel.tintColor = .orange
                }
            }
            
            present(statusVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Methods
    
    @objc private func sendDataWithObserver(notification: Notification) {
        if let userStatus = notification.userInfo {
            if userStatus["UserStatus"] as! String == "confirmed" {
                print("вы вошли")
                AlertHelper.shared.show(for: self,
                                        title: "You are logined",
                                        message: "",
                                        rightBittonTitle: "Ok",
                                        actionStyle: .default,
                                        rightBittonAction: nil)
            } else {
                print("вы не вошли")
                AlertHelper.shared.show(for: self,
                                        title: "Error",
                                        message: "You are not logined",
                                        rightBittonTitle: "Ok",
                                        actionStyle: .default,
                                        rightBittonAction: nil)
            }
        }
    }
    
    private func setupAuthUI() {
        self.view.backgroundColor = .gray
        self.hidenLabel.isHidden = true
        
        self.usernameTextField.placeholder = "Enter your name"
        self.usernameTextField.clearButtonMode = .whileEditing
        
        self.userPasswordTextField.placeholder = "Enter your password"
        self.userPasswordTextField.clearButtonMode = .whileEditing
        self.userPasswordTextField.isSecureTextEntry = true
        
        self.loginButton.layer.cornerRadius = 5
        self.loginButton.backgroundColor = .systemBlue
        self.loginButton.setTitle("Logine", for: .normal)
        self.loginButton.setTitleColor(.white, for: .normal)
    }
}

