//
//  ConfigurableCell.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

public protocol ConfigurableCell: class {

    associatedtype DataObject

    func configure(forObject object: DataObject)

    static var reuseIdentifier: String { get }
}

extension ConfigurableCell {
    static var reuseIdentifier: String {
        return className(fromModuleClassName: self)!
    }
}
