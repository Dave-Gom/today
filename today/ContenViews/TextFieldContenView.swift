//
//  TextFieldContenView.swift
//  today
//
//  Created by Dave on 2025-07-05.
//

import UIKit

class TextFieldContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var text: String? = ""


        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
    }


    let textField = UITextField()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }


    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }


    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16))
        textField.clearButtonMode = .whileEditing
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textField.text = configuration.text
    }
}


extension UICollectionViewCell {
    func textFieldConfiguration() -> TextFieldContentView.Configuration{
        TextFieldContentView.Configuration()
    }
}
