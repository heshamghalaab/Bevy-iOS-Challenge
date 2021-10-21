//
//  MainFlowPresenter.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

struct MainFlowPresenter {
    
    private let window: UIWindow
    
    init() {
        window = UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
    
    func navigate(to controller: UIViewController,
                  options: UIView.AnimationOptions = [.transitionCrossDissolve]){
        clearPresntedControllersIfNeeded()
        setTransition(options: options)
        setRoot(to: controller)
    }
    
    private func clearPresntedControllersIfNeeded(){
        guard window.rootViewController?.presentedViewController != nil else {return}
        window.rootViewController?.dismiss(animated: false, completion: {
            self.clearPresntedControllersIfNeeded()
        })
    }
    
    private func setRoot(to rootViewController: UIViewController){
        window.makeKeyAndVisible()
        window.rootViewController = rootViewController
    }
    
    private func setTransition(options: UIView.AnimationOptions){
        UIView.transition(
            with: window, duration: 0.55001,
            options: options, animations: nil, completion: nil)
    }
}
