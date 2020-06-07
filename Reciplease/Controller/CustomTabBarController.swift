//
//  CustomTabBarController.swift
//  Reciplease
//
//  Created by Cedric on 03/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarFont()
    }
    // sets the font of the tab Bar
    private func setTabBarFont() {
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "beau", size: 18.0),
                              NSAttributedString.Key.foregroundColor: UIColor.white]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key: Any], for: .normal)
    }
}
