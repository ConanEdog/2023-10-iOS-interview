//
//  DownloadImageView.swift
//  v1
//
//  Created by 方奎元 on 2023/10/29.
//

import UIKit

class DownloadImageView: UIImageView {

    private let indicatorView = UIActivityIndicatorView(style: .large)
    private let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareView()
    }
    
    private func prepareView() {
        self.backgroundColor = UIColor(named: "imgBackground")
        indicatorView.frame = CGRect(x: 0, y: 0, width: self.frame.width/2, height: self.frame.height/2)
        button.backgroundColor = UIColor(named: "adIcon")
        button.layer.cornerRadius = 8
        button.setTitle("AD", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textColor = .white
        
        indicatorView.color = .darkGray
        self.addSubview(button)
        self.addSubview(indicatorView)
        
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo:  self.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: (self.frame.width - 96)/2),
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: (self.frame.height - 48)/2),
            button.widthAnchor.constraint(equalToConstant: 48),
            button.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func prepareIconView() {
        
        

        
    }

    func loadAsync(url: URL) async throws {
        indicatorView.startAnimating()
        self.button.removeFromSuperview()
        let (data, response) = try await URLSession.shared.data(from: url)
        indicatorView.stopAnimating()
//        print(response)
//        print(data)
        let image = UIImage(data: data)
        self.image = image

    }
}
