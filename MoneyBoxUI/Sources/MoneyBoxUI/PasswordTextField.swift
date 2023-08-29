//
//  PasswordTextField.swift
//  
//
//  Created by George Woodham on 25/08/23.
//

import UIKit

public final class PasswordTextField: UITextField {
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        placeholder = "Password"
        borderStyle = .roundedRect
        textContentType = .password
        backgroundColor = .tertiarySystemBackground
        isSecureTextEntry = true
        clearButtonMode = .always
    }
}
