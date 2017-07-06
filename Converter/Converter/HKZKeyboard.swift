//
//  HKZKeyboard.swift
//  Converter
//
//  Created by 赵香港 on 17/7/6.
//  Copyright © 2017年 HK. All rights reserved.
//

import UIKit

class HKZKeyboard: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size.width = kScreenWith
        self.frame.size.height = kScreenWith/5.0*4;
        self.backgroundColor = UIColor.blue
        self.setupButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupButtons()

    }
    
    func setupButtons() {
        var numbers = [[String]]()
        
        numbers = [["7","8","9","A","B"],
                   ["4","5","6","C","D"],
                   ["1","2","3","A","B"],
                   ["0","","","清空","x"]];
        
        for i in 0..<numbers.count {
            for j in 0..<numbers[i].count {
                let width:CGFloat = kScreenWith/5.0,height = width
                let left:CGFloat = CGFloat(j)*width;
                let top = CGFloat(i)*height
                
                let btn:UIButton = UIButton()
                btn.frame = CGRect(x: left, y: top, width: width, height: height)
                btn.setTitle(numbers[i][j], for:UIControlState.normal)
                btn.backgroundColor = UIColor(red: 225.0, green: 225.0, blue: 225.0, alpha: 1.0)
                btn.setTitleColor(UIColor.black, for: .normal)
                btn.setTitleColor(UIColor.blue, for: .highlighted)
                btn.layer.borderWidth = 0.5;
                btn.layer.borderColor = UIColor.blue.cgColor
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                self.addSubview(btn)
            }
        }
    }
    
}
