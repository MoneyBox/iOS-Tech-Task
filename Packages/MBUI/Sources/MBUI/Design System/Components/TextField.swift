import UIKit

public final class TextField: UITextField {

    // MARK: - Types

    public enum Style {
        case unknown
        case email
        case password
    }

    // MARK: - Init

    public init(
        placeholder: String = "",
        style: Style = .unknown
    ) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        configure(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: -

    private func configure(style: Style = .unknown) {
        borderStyle = .roundedRect
        layer.cornerRadius = 8
        layer.borderColor = UIColor.color1.cgColor
        layer.borderWidth = 1.0
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        layer.masksToBounds = true

        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.color5]
        )
        textColor = .color6
        backgroundColor = .color2

        translatesAutoresizingMaskIntoConstraints = false

        switch style {
        case .email:
            keyboardType = .emailAddress
            autocapitalizationType = .none
            autocorrectionType = .no

        case .password:
            isSecureTextEntry = true

        case .unknown: break
        }
    }
}
