//
//  MessageCell.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.dotView.layer.cornerRadius = 6
        self.dotView.backgroundColor = UIColor(named: "dot")
        self.titleLabel.textColor = UIColor(named: "title")
        self.subtitleLabel.textColor = UIColor(named: "title")
        self.contentLabel.textColor = UIColor(named: "content")
        self.cellBackgroundView.backgroundColor = UIColor(named: "background")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ vm: MessageViewModel) {
        self.titleLabel.text = vm.title
        self.subtitleLabel.text = vm.updateDateTime
        self.contentLabel.text = vm.message
        self.dotView.isHidden = vm.status
    }
    
}
