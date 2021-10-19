//
//  String+Url.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import UIKit

extension String {
    var isValidUrl: Bool {
        guard let url = URL(string: self) else { return false }

        var canOpenURL: Bool = false

        if Thread.isMainThread {
            canOpenURL = UIApplication.shared.canOpenURL(url)
        } else {
            DispatchQueue.main.sync {
                canOpenURL = UIApplication.shared.canOpenURL(url)
            }
        }

        if !canOpenURL { return false }

        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }
}
