//
//  StationInfoButton.swift
//  BAT_iOS_testing
//
//  Created by Dawei Hao on 2024/9/9.
//

import UIKit

class StationInfoButton: UIButton {
    
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
        config.baseForegroundColor = Colors.white
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 18)
        config.attributedTitle = AttributedString("站點資訊", attributes: container)
        config.titleAlignment      = .leading
        config.cornerStyle         = .capsule
        config.showsActivityIndicator = false
        self.configuration         = config

        configurationUpdateHandler = { button in
            var config = button.configuration
            config?.baseForegroundColor = button.isHighlighted ? UIColor.darkGray : UIColor.white
            button.configuration = config
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
