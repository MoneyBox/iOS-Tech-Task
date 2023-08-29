//
//  EmailTextField.swift
//  
//
//  Created by George Woodham on 25/08/23.
//

import UIKit

public final class EmailsTextField: UITextField {
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        placeholder = "Email"
        borderStyle = .roundedRect
        textContentType = .emailAddress
        backgroundColor = .tertiarySystemBackground
        clearButtonMode = .always
    }
}
