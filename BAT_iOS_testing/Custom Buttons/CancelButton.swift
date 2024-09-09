//
//  CancelButton.swift
//  BAT_iOS_testing
//
//  Created by Dawei Hao on 2024/9/9.
//

import UIKit

class CancelButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit () {
        var config                 = UIButton.Configuration.plain()
        config.baseForegroundColor = Colors.hexStringToUIColor(hex: "#B5CC22")
        config.image = Images.cancel
        config.background.imageContentMode = .scaleAspectFit
        config.titleAlignment      = .leading
        config.cornerStyle         = .capsule
        config.showsActivityIndicator = false
        self.configuration         = config

        configurationUpdateHandler = { button in
            button.alpha = button.isHighlighted ? 0.5 : 1
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
