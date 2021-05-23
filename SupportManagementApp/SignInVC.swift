//
//  SignInVC.swift
//  SupportManagementApp
//
//  Created by HBO on 17.05.2021.
//

import UIKit

class SignInVC: UICollectionViewCell {
    
    let logoImageView = UIImageView()
    let emailTextField = CustomTextField()
    let passwordTextField = CustomTextField()
    let callToActionButton = CustomButton(backgroundColor: .systemGreen, title: "Giriş")

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        configureLogoImageView()
        configureEmailTextfield()
        configurePasswordTextField()
        configurationCallToActionButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }*/
    
    
    func configureLogoImageView() {
        self.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureEmailTextfield() {
        self.addSubview(emailTextField)
        emailTextField.placeholder = "Epostanızı giriniz..."
        emailTextField.keyboardType = .emailAddress;
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configurePasswordTextField() {
        self.addSubview(passwordTextField)
        passwordTextField.placeholder = "Şifrenizi giriniz..."
        passwordTextField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configurationCallToActionButton() {
        self.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
