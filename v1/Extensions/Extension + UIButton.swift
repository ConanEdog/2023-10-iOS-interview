//
//  Extension + UIButton.swift
//  v1
//
//  Created by 方奎元 on 2023/10/27.
//

import UIKit

extension UIButton {
    
    func verticalSet(title: String, imageName: String) {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        var btnConfig = UIButton.Configuration.plain()
        btnConfig.imagePlacement = .top
        btnConfig.titleLineBreakMode = .byTruncatingTail
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        btnConfig.attributedTitle = AttributedString(title, attributes: container)
        btnConfig.image = UIImage(named: imageName, in: nil, with: config)
        btnConfig.imagePadding = 2
        self.configuration = btnConfig
        self.tintColor = UIColor(named: "unselectedColor")
    }
    
    func largeVerticalSet(title: String, imageName: String, fontSize:CGFloat, imageSize: CGFloat, fontWeight: UIFont.Weight) {
        let config = UIImage.SymbolConfiguration(pointSize: imageSize, weight: .regular)
        var btnConfig = UIButton.Configuration.plain()
        btnConfig.imagePlacement = .top
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        btnConfig.attributedTitle = AttributedString(title, attributes: container)
        btnConfig.image = UIImage(named: imageName, in: nil, with: config)
        btnConfig.imagePadding = 2
        self.configuration = btnConfig
        self.tintColor = UIColor(named: "unselectedColor")
        
    }
    
    func rightImage(title: String, imageName: String) {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        var btnConfig = UIButton.Configuration.plain()
        btnConfig.imagePlacement = .trailing
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        btnConfig.attributedTitle = AttributedString(title, attributes: container)
        btnConfig.image = UIImage(named: imageName, in: nil, with: config)
        btnConfig.imagePadding = 2
        self.configuration = btnConfig
        self.tintColor = UIColor(named: "unselectedColor")
        
    }
}



