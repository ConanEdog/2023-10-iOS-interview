//
//  HeaderView.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import UIKit

class HeaderView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    func configure() {
        self.backgroundColor = UIColor(named: "background")
        self.titleLabel.text = "My Favorite"
        self.titleLabel.textColor = UIColor(named: "BalanceTitle")
        self.titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        
        self.moreBtn.rightImage(title: "More", imageName: "rightArrow")
    }
}
