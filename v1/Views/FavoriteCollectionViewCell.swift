//
//  FavoriteCollectionViewCell.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteBtn: UIButton!
    
    func configure(vm: FavoriteViewModel) {
        self.favoriteBtn.tintColor = UIColor(named: "placeholder")
        self.favoriteBtn.largeVerticalSet(title: vm.nickName, imageName: vm.transType.rawValue, fontSize: 12, imageSize: 56, fontWeight: .regular)
    }
    
}

