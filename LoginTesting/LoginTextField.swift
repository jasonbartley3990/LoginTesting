//
//  LoginTextField.swift
//  LoginTesting
//
//  Created by Jason bartley on 1/11/22.
//

import UIKit

class LoginTextField: UITextField {

    override init(frame: CGRect){
        super.init(frame: frame)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftViewMode = .always
        textColor = .label
        layer.cornerRadius = 8
        layer.borderWidth = 1
        backgroundColor = .secondarySystemBackground
        layer.borderColor = UIColor.label.cgColor
        autocapitalizationType = .none
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
