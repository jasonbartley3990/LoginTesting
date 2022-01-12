//
//  extensions.swift
//  LoginTesting
//
//  Created by Jason bartley on 1/11/22.
//

import Foundation
import UIKit

extension UIView {
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        frame.origin.y+height
    }
    var height: CGFloat {
        frame.size.height
    }
    var width: CGFloat {
        frame.size.width
    }
    var right: CGFloat {
        frame.origin.x+width
    }
    var left: CGFloat {
        frame.origin.x
    }
}
