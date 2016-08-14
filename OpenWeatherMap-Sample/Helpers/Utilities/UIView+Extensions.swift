//
//  UIView+Extensions.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

extension UIView {
    static var nibName: String {
        return className(fromModuleClassName: self)!
    }

    static func loadFromNib(nibNameOrNil: String? = nil) -> Self {
        return loadFromNib(nibNameOrNil, type: self)
    }

    static func loadFromNib<T: UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T {
        let name = nibNameOrNil ?? self.nibName

        let nib = UINib(nibName: name, bundle: nil)

        return nib.instantiateWithOwner(self, options: nil).first as! T
    }
}
