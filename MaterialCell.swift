//
//  MaterialCell.swift
//  Shopping Training App
//
//  Created by Mark Rabins on 4/5/17.
//  Copyright © 2017 Ensighten Inc. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView {
    @IBInspectable var materialDesign: Bool {
        get {
            return materialKey
        } set {
            materialKey = newValue
            
            if materialKey {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 1.5
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 4.0, height: 6.0)
                self.layer.shadowColor = UIColor(red: 255.0/255.0, green: 180.0/255.0, blue: 0/255.0, alpha: 0.3).cgColor
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
    }
}

