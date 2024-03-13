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
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onBoardingViewController.delegate = self
        dummyViewController.logoutDelegate = self
        window?.rootViewController = mainViewController
        mainViewController.selectedIndex = 0
        return true
    }
}

extension AppDelegate : LoginViewControllerDelegate{
    func didLogin() {
        if LocalState.hasOnboarded{
            setRootViewController(dummyViewController)
        }else{
            setRootViewController(onBoardingViewController)
        }
    }
    
}
extension AppDelegate : OnBoardingContainerViewControllerDelegate{
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(dummyViewController)
    }
}

extension AppDelegate : LogoutViewControllerDelegate{
    func didLogout() {
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
