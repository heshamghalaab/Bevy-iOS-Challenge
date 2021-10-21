//
//  SplashViewController.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let navigationController = EventsNavigationController.instantiate(from: .main)
            if let viewController = navigationController.viewControllers.first as? EventsViewController{
                viewController.viewModel = EventsViewModel()
            }
            MainFlowPresenter().navigate(to: navigationController)
        }
    }
}
