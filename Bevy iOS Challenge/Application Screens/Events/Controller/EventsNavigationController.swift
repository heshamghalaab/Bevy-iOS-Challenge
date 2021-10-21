//
//  EventsNavigationController.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

class EventsNavigationController: UINavigationController {
    
    // MARK: - View controller lifecycle methods

    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    // MARK: - Configuration methods
    
    /// Custom UINavigationBarAppearance
    private func setupAppearance(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
