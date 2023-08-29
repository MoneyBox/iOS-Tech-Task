//
//  MBButton.swift
//  
//
//  Created by George Woodham on 25/08/23.
//

import UIKit

public final class MBButton: UIButton {
    
    public enum ButtonStyle {
        case primary
        case secondary
    }
    
    public init(style: ButtonStyle) {
        super.init(frame: .zero)
        
        if #available(iOS 15.0, *) {
            configureButtonStyleiOS15(with: style)
        } else {
            configureButtonStyle(with: style)
        }
        
        heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(iOS 15, *)
    private func configureButtonStyleiOS15(with style: ButtonStyle) {
        var config: UIButton.Configuration
    
        switch style {
        case .primary:
            config = UIButton.Configuration.filled()
        case .secondary:
            config = UIButton.Configuration.plain()
            var background = UIButton.Configuration.plain().background
            background.strokeWidth = 2
            background.strokeColor = UIColor(named: "AccentColor")
            config.background = background
        }
    
        config.cornerStyle = .small
        
        configuration = config
    }
    
    private func configureButtonStyle(with style: ButtonStyle) {

        layer.cornerRadius = 4
        clipsToBounds = true
        
        switch style {
        case .primary:
            backgroundColor = UIColor(named: "AccentColor")
        case .secondary:
            layer.borderColor = UIColor(named: "AccentColor")?.cgColor
            layer.borderWidth = 2
            setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        }
    }
}
