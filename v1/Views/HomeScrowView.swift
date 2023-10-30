//
//  homeScrowView.swift
//  v1
//
//  Created by 方奎元 on 2023/10/27.
//

import UIKit

class HomeScrowView: UIScrollView {

    private var lastViewY: CGFloat = 1200
    //var eyeBtn: UIButton!
    var titleLabel: UILabel!
    var usdLabel: UILabel!
    var khrLabel: UILabel!
    var titleView = UIView(frame: .zero)
    
    
    private func setupBalanceView() {
        usdLabel = UILabel()
        khrLabel = UILabel()
        guard let usdLabel = usdLabel, let khrLabel = khrLabel else {
            return
        }
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 24))
//        eyeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
//        eyeBtn.setImage(UIImage(named: "eyeOn"), for: .normal)
        
        
        self.addSubview(titleView)
        titleView.addSubview(titleLabel)
//        self.addSubview(eyeBtn)
        
        titleLabel.text = "My Account Balance"
        titleLabel.textColor = UIColor(named: "BalanceTitle")
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        
        let usdTileLabel = UILabel()
        usdTileLabel.text = "USD"
        usdTileLabel.textColor = UIColor(named: "unselectedColor")
        usdTileLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        usdLabel.text = "**********"
        usdLabel.textColor = UIColor(named: "**")
        usdLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
        let khrtitleLabel = UILabel()
        khrtitleLabel.text = "KHR"
        khrtitleLabel.textColor = UIColor(named: "unselectedColor")
        khrtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        khrLabel.text = "**********"
        khrLabel.textColor = UIColor(named: "**")
        khrLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        eyeBtn.translatesAutoresizingMaskIntoConstraints = false
        usdTileLabel.translatesAutoresizingMaskIntoConstraints = false
        usdLabel.translatesAutoresizingMaskIntoConstraints = false
        khrtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        khrLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(usdTileLabel)
        self.addSubview(khrtitleLabel)
        self.addSubview(usdLabel)
        self.addSubview(khrLabel)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.topAnchor),
            titleView.leftAnchor.constraint(equalTo: self.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: self.rightAnchor),
            //titleView.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor,constant: 24),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 12),
            
//            eyeBtn.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8),
//            eyeBtn.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 12),
            
            usdTileLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            usdTileLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 28 ),
            usdLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            usdLabel.topAnchor.constraint(equalTo: usdTileLabel.bottomAnchor),
            khrtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            khrtitleLabel.topAnchor.constraint(equalTo: usdLabel.bottomAnchor, constant: 8),
            khrLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            khrLabel.topAnchor.constraint(equalTo: khrtitleLabel.bottomAnchor)
            
            
        ])
        
    }
    
    func setup() {
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor),
            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor)
        ])
        
        self.setupBalanceView()
    }
    
    
    
}


