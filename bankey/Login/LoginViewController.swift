//
//  ViewController.swift
//  bankey
//
//  Created by Irfan Dary Sujatmiko on 05/03/24.
//

import UIKit

protocol LogoutViewControllerDelegate:AnyObject{
    func didLogout()
}
protocol LoginViewControllerDelegate:AnyObject{
    
    func didLogin()
}

class LoginViewController: UIViewController {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMesage = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username:String?{
        return loginView.usernameTextField.text
    }
    var password:String?{
        return loginView.passwordTextField.text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
        loginView.usernameTextField.text = ""
        loginView.passwordTextField.text = ""
        
    }
    
    
}
extension LoginViewController{
    private func style(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
               subtitleLabel.textAlignment = .center
               subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
               subtitleLabel.adjustsFontForContentSizeCategory = true
               subtitleLabel.numberOfLines = 0
               subtitleLabel.text = "Your premium source for all things banking!"
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        
        errorMesage.translatesAutoresizingMaskIntoConstraints = false
        errorMesage.textAlignment = .center
        errorMesage.textColor = .systemRed
        errorMesage.numberOfLines = 0
        errorMesage.isHidden = true
        
        
    }
    
    private func layout(){
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMesage)
        NSLayoutConstraint.activate([
                    subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
                    titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                ])
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
       
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            errorMesage.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMesage.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMesage.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor),
        ])
    }
}

extension LoginViewController{
    @objc func signInTapped(){
        errorMesage.isHidden = true
        login()
    }
    
    private func login(){
        guard let username = username, let password = password else{
            assertionFailure("Username and password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty{
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "Kevin" && password == "Welcome"{
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        }else{
            configureView(withMessage: "Incorrect username/password")
        }
    }
    
    private func configureView(withMessage message:String){
        errorMesage.text = message
        errorMesage.isHidden = false
    }
}

