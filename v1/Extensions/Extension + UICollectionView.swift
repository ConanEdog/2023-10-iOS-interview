//
//  Extension + UICollectionView.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import UIKit

extension UICollectionView {
    func indexPathForCellContaining( view: UIView) -> IndexPath? {
        let viewCenter = self.convert(view.center, from: view.superview)
        return self.indexPathForItem(at: viewCenter)
    }
    
    func setEmptyMessage(_ message: String) {
        
        let btn = UIButton()
        btn.largeVerticalSet(title: "---", imageName: "empty", fontSize: 12, imageSize: 56, fontWeight: .regular)
        btn.isEnabled = false
        btn.tintColor = UIColor(named: "placeholder")
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.textColor = UIColor(named: "placeholder")
        messageLabel.numberOfLines = 2
        messageLabel.sizeToFit()
        
        let mainView = UIView()
        mainView.addSubview(btn)
        mainView.addSubview(messageLabel)
        
        //Auto Layout
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btn.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 24),
            btn.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 25),
                       
            messageLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 40),
            messageLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 17),
            messageLabel.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 2/3)
        ])
        mainView.backgroundColor = UIColor(named: "background")
        
       
        self.backgroundView = mainView
    }
    
    func restoreBackgroundView() {
        let view = UIView()
        view.backgroundColor = UIColor(named: "background")
        self.backgroundView = view
    }
    
}
