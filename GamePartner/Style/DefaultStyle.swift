//
//  DefaultStyle.swift
//  GamePartner
//
//  Created by 문효재 on 2020/10/25.
//

import UIKit

public enum DefaultStyle {
    public enum Colors {
        public static let text: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor { traitCollction in
                    if traitCollction.userInterfaceStyle == .dark {
                        return .white
                    } else {
                        return .black
                    }
                }
            } else {
                return .black
            }
        }()
        
        public static let tint:UIColor = .systemPink
    }
    
    public enum Radius {
        public static let button: CGFloat = 10
        public static let TextField: CGFloat = 4
    }
}
