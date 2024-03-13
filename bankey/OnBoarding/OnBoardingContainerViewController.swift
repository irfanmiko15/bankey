//
//  OnBoardingContainerViewController.swift
//  bankey
//
//  Created by Irfan Dary Sujatmiko on 06/03/24.
//

import Foundation
import UIKit

protocol OnBoardingContainerViewControllerDelegate: AnyObject{
    func didFinishOnboarding()
}

class OnBoardingContainerViewController:UIViewController{
    let pageViewController: UIPageViewController
        var pages = [UIViewController]()
    weak var delegate:OnBoardingContainerViewControllerDelegate?
       
        let closeButton = UIButton(type: .system)
        let nextButton = UIButton(type: .system)
        let backButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    
    var currentVC:UIViewController{
        didSet{
            guard let index = pages.firstIndex(of: currentVC) else {return}
            nextButton.isHidden = index == pages.count - 1
            backButton.isHidden = index == 0
            doneButton.isHidden = !(index == pages.count - 1)
        }
    }
        
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            
            let page1 = OnboardingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s.")
            let page2 = OnboardingViewController(heroImageName: "world", titleText: "Move your money around the world quickly and securely.")
            let page3 = OnboardingViewController(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com.")
            
            pages.append(page1)
            pages.append(page2)
            pages.append(page3)
            
            currentVC = pages.first!
            
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setup()
            style()
            layout()
        }
        
        private func setup() {
            view.backgroundColor = .systemPurple
            
            addChild(pageViewController)
            view.addSubview(pageViewController.view)
            pageViewController.didMove(toParent: self)
            
            pageViewController.dataSource = self
            pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
                view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
            ])
            
            pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
            currentVC = pages.first!
        }
        
        private func style() {
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.setTitle("Next", for: [])
            nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
            
            backButton.translatesAutoresizingMaskIntoConstraints = false
            backButton.setTitle("Back", for: [])
            backButton.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
            
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.setTitle("Close", for: [])
            closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
            
            doneButton.translatesAutoresizingMaskIntoConstraints = false
            doneButton.setTitle("Done", for: [])
            doneButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
        }
        
        private func layout() {
            
            
            view.addSubview(nextButton)
            view.addSubview(backButton)
            view.addSubview(closeButton)
            view.addSubview(doneButton)
            
            NSLayoutConstraint.activate([
                view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
                view.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 4)
            ])
            
            NSLayoutConstraint.activate([
                backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
                view.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 4)
            ])
        
            // Close
            NSLayoutConstraint.activate([
                closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
                closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
            ])
            
            NSLayoutConstraint.activate([
                view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
                view.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 4)
            ])
        }
    }

    // MARK: - UIPageViewControllerDataSource
    extension OnBoardingContainerViewController: UIPageViewControllerDataSource {

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            return getPreviousViewController(from: viewController)
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            return getNextViewController(from: viewController)
        }

        private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
            guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
            currentVC = pages[index - 1]
            return pages[index - 1]
        }

        private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
            guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
            currentVC = pages[index + 1]
            return pages[index + 1]
        }

        func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return pages.count
        }

        func presentationIndex(for pageViewController: UIPageViewController) -> Int {
            return pages.firstIndex(of: self.currentVC) ?? 0
        }
}

extension OnBoardingContainerViewController {
    @objc func closeTapped(_ sender: UIButton) {
        LocalState.hasOnboarded = true
        delegate?.didFinishOnboarding()
    }
    @objc func doneTapped(_ sender: UIButton) {
        LocalState.hasOnboarded = true
        delegate?.didFinishOnboarding()
    }
    @objc func nextTapped(_ sender: UIButton) {
        guard let nextVC = getNextViewController(from: currentVC) else {return}
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true,completion: nil)
        
    }
    @objc func backTapped(_ sender: UIButton) {
        guard let nextVC = getPreviousViewController(from: currentVC) else {return}
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true,completion: nil)
        
    }
}