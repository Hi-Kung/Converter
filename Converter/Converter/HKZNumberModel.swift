//
//  HKZNumberModel.swift
//  Converter
//
//  Created by 赵香港 on 17/6/11.
//  Copyright © 2017年 HK. All rights reserved.
//

import Foundation

class HKZNumberModel {
    var name:String
    var number: String
    init?(name:String, number:String) {
        if name.isEmpty || number.isEmpty {
            return nil;
        }
        self.name = name
        self.number = number
    }
}


		
