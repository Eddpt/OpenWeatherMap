//
//  Utilities.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

public func className(fromModuleClassName anyClass: AnyClass) -> String? {
    let fullClassName = NSStringFromClass(object_getClass(anyClass))
    let nameComponents = fullClassName.componentsSeparatedByString(".")

    return nameComponents.last
}