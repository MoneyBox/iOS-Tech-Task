//
//  Button.swift
//
//
//  Created by Filippo Minelle on 21/09/2023.
//

import UIKit

public final class Button: UIButton {

    // MARK: - Types

    public enum Style {
        case primary
        case secondary
        case custom
    }

    // MARK: - Properties

    let cornerRadius = 8.0

    // MARK: - Init

    public init(
        title: String,
        style: Style = .primary,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        super.init(frame: .zero)

        setTitle(title, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false

        if let target, let action {
            addTarget(target, action: action, for: .touchUpInside)
        }

        configure(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: -

    private func configure(style: Style) {
        heightAnchor.constraint(equalToConstant: 45).isActive = true

        switch style {
        case .primary:
            setTitleColor(.color2, for: .normal)
            backgroundColor = .color1
            layer.cornerRadius = cornerRadius
            widthAnchor.constraint(equalToConstant: 200).isActive = true

        case .secondary:
            setTitleColor(.color1, for: .normal)
            backgroundColor = .clear
            layer.borderWidth = 2.0
            layer.borderColor = UIColor.color1.cgColor
            layer.cornerRadius = cornerRadius
            widthAnchor.constraint(equalToConstant: 200).isActive = true

        case .custom:
            break
        }
    }
}
