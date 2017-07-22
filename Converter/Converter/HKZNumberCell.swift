//
//  HKZNumberCell.swift
//  Converter
//
//  Created by  on 17/6/11.
//  Copyright © 2017年 HK. All rights reserved.
//

import UIKit

class HKZNumberCell: UITableViewCell {
    // MARK:Properties
    var leftNameLabel = UILabel()
    var numberLabel = UILabel()
    var numberModel = HKZNumberModel(name:"", number:"") {
        didSet{
            leftNameLabel.text = numberModel?.name
            numberLabel.text = numberModel?.number
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let cellH:CGFloat = 60, nameW:CGFloat = 50, nameLeft:CGFloat = 10
        
        leftNameLabel.frame = CGRect(x: nameLeft, y: 0, width: nameW, height: cellH)
        numberLabel.frame = CGRect(x: nameLeft+nameW, y: 0, width: kScreenWith-nameLeft*2-nameW, height: cellH)
        numberLabel.numberOfLines = 2
        numberLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(leftNameLabel)
        self.contentView.addSubview(numberLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
