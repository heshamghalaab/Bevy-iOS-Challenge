//
//  LoadingView.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

class LoadingView {

    static var spinner: UIActivityIndicatorView?

    static func show() {
        DispatchQueue.main.async {
            guard spinner == nil, let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            let frame = UIScreen.main.bounds
            let spinner = UIActivityIndicatorView(frame: frame)
            spinner.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            spinner.style = UIActivityIndicatorView.Style.large
            spinner.color = .white
            window.addSubview(spinner)
            
            spinner.startAnimating()
            self.spinner = spinner
        }
    }

    static func hide() {
        DispatchQueue.main.async {
            guard let spinner = spinner else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
        }
    }
}
