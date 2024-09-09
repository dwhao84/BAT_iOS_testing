//
//  MenuView.swift
//  BAT_iOS_testing
//
//  Created by Dawei Hao on 2024/9/9.
//

import UIKit

class MenuView: UIView {
    let bottomView: UIView   = UIView()
    let topView: UIView      = UIView()
    let grayLineView: UIView = UIView()
    
    let instructionBtn: InstructionButton = InstructionButton()
    let chargingBtn: ChargingButton       = ChargingButton()
    let stationInfoBtn: StationInfoButton = StationInfoButton()
    let eventAreaBtn: EventAreaButton     = EventAreaButton()
    let newsBtn: NewsButton               = NewsButton()
    
    let loginBtn: LoginButton = LoginButton()
    let cancelBtn: CancelButton = CancelButton()
    
    let ubikeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.youbike
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let btnsStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        cancelBtn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismiss () {
        print("MenuView Dismiss")
        self.removeFromSuperview()
    }
    
    func setupUI () {
        configInnerView()
        configBtnStackView()
        self.addSubview(loginBtn)
        addConstraints()
    }
    
    func configInnerView () {
        topView.backgroundColor = Colors.white
        bottomView.backgroundColor = Colors.hexStringToUIColor(hex: "#B5CC22")
        grayLineView.backgroundColor = Colors.hexStringToUIColor(hex: "#EBEBEB")
        self.addSubview(bottomView)
        self.addSubview(topView)
        self.addSubview(grayLineView)
    }
    
    func configBtnStackView () {
        btnsStackView.addArrangedSubview(instructionBtn)
        btnsStackView.addArrangedSubview(chargingBtn)
        btnsStackView.addArrangedSubview(stationInfoBtn)
        btnsStackView.addArrangedSubview(newsBtn)
        btnsStackView.addArrangedSubview(eventAreaBtn)
    }
    
    func addConstraints () {
        topView.addSubview(ubikeImageView)
        topView.addSubview(cancelBtn)
        bottomView.addSubview(loginBtn)
        bottomView.addSubview(btnsStackView)
        ubikeImageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        ubikeImageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        grayLineView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            cancelBtn.widthAnchor.constraint(equalToConstant: 16),
            cancelBtn.heightAnchor.constraint(equalToConstant: 16),
            cancelBtn.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -32),
            cancelBtn.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            ubikeImageView.widthAnchor.constraint(equalToConstant: 65),
            ubikeImageView.heightAnchor.constraint(equalToConstant: 65),
            ubikeImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 32),
            ubikeImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            // topView
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 72),
            // grayLineView
            grayLineView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            grayLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            grayLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            grayLineView.heightAnchor.constraint(equalToConstant: 2),
            // bottomView
            bottomView.topAnchor.constraint(equalTo: grayLineView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        // Login Btn
        NSLayoutConstraint.activate([
            loginBtn.widthAnchor.constraint(equalToConstant: 82),
            loginBtn.heightAnchor.constraint(equalToConstant: 40),
            loginBtn.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 32),
            loginBtn.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -32)
        ])
        
        // Btns stackview
        NSLayoutConstraint.activate([
            btnsStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 32),
            btnsStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24)
        ])
    }
    
}

#Preview(traits: .fixedLayout(width: 375, height: 667), body: {
    let menuView: UIView = MenuView()
    return menuView
})
