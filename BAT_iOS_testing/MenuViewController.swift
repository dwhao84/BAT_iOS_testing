//
//  MenuViewController.swift
//  BAT_iOS_testing
//
//  Created by Dawei Hao on 2024/9/9.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Color.hexStringToUIColor(hex: "#B5CC22")
        // Do any additional setup after loading the view.
    }

    func setupUI () {
        
    }
    
    
}

#Preview {
    UINavigationController(rootViewController: MenuViewController())
}
