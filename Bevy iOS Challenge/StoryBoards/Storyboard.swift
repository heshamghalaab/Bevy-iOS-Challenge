//
//  Storyboard.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

enum Storyboard : String {
    
    case main = "Main"
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyBoard = UIStoryboard(name: self.rawValue, bundle: Bundle.main)
        let viewControllerId = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = storyBoard.instantiateViewController(withIdentifier: viewControllerId) as? T else {
            fatalError("ViewController with identifier \(viewControllerId), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")}
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        UIStoryboard(name: self.rawValue, bundle: Bundle.main).instantiateInitialViewController()
    }
}

extension UIViewController {
    class var storyboardID : String { return "\(self)"}
    
    static func instantiate(from storyboard: Storyboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
}
