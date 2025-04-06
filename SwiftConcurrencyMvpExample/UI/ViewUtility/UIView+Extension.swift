//
//  UIView+Extension.swift
//  SwiftConcurrencyMvpExample
//
//  Created by 佐藤汰一 on 2025/04/05.
//

import UIKit

extension UIView {
    
    static func makeSpacer(_ height: CGFloat) -> UIView {
        
        let spaceView = UIView()
        spaceView.backgroundColor = .clear
        
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        spaceView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return spaceView
    }
}
