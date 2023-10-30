//
//  BtnCollectionViewCell.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import UIKit

class BtnCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btn: UIButton!
    
    func configure(index: Int) {
        self.backgroundColor = UIColor(named: "background")
        switch index {
        case 0:
            self.btn.largeVerticalSet(title: "Transfer", imageName: "transfer" ,fontSize: 14, imageSize: 56, fontWeight: .regular)
        case 1:
            self.btn.largeVerticalSet(title: "Payment", imageName: "payment",fontSize: 14, imageSize: 56, fontWeight: .regular)
        case 2:
            self.btn.largeVerticalSet(title: "Utility", imageName: "utility",fontSize: 14, imageSize: 56, fontWeight: .regular)
        case 3:
            self.btn.largeVerticalSet(title: "QR pay scan", imageName: "scan",fontSize: 14, imageSize: 56, fontWeight: .regular)
        case 4:
            self.btn.largeVerticalSet(title: "My QR code", imageName: "qrcode",fontSize: 14, imageSize: 56, fontWeight: .regular)
        case 5:
            self.btn.largeVerticalSet(title: "Top up", imageName: "topUp",fontSize: 14, imageSize: 56, fontWeight: .regular)
            
        default:
            break
            
        }
        
//        self.btn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
//    @objc func pressed() {
//        print("btn \(btn.titleLabel?.text)")
//        if let collectionView = self.superview as? UICollectionView {
//            let index = collectionView.indexPathForCellContaining(view: self.btn)
//            print("Btn index: \(index)")
//        }
//    }
    
}
