//
//  AppDelegate.swift
//  bankey
//
//  Created by Irfan Dary Sujatmiko on 05/03/24.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var loginViewController = LoginViewController()
    let onBoardingViewController = OnBoardingContainerViewController()
    let mainViewController = MainViewController()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onBoardingViewController.delegate = self
        registerForNotification()
        displayLogin()
        
        return true
    }
    
    private func registerForNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    
    private func displayLogin(){
        setRootViewController(loginViewController)
    }
    
    private func displayNextScreen(){
        if LocalState.hasOnboarded{
            prepMainView()
            setRootViewController(mainViewController)
        }
        else{
            setRootViewController(onBoardingViewController)
        }
    }
    
    private func prepMainView(){
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
}

extension AppDelegate : LoginViewControllerDelegate{
    func didLogin() {
      displayNextScreen()
    }
    
}
extension AppDelegate : OnBoardingContainerViewControllerDelegate{
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
    }
}

extension AppDelegate : LogoutViewControllerDelegate{
    @objc func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate{
    func setRootViewController(_ vc:UIViewController,animated:Bool = true){
        guard animated,let window = self.window else{
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve,animations: nil,completion: nil)
    }
}
