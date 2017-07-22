//
//  HKZConverterBaseVC.swift
//  Converter
//
//  Created by  on 17/6/11.
//  Copyright © 2017年 HK. All rights reserved.
//

import UIKit
let kScreenWith   = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kStatusBarHeight:CGFloat = 20.0
let kNavigationBarHeight:CGFloat = 44.0
let kTabbarHeight:CGFloat = 49.0

enum BaseNumberType:Int32 {
    case binary = 2
    case octal = 8
    case decimal = 10
    case hexadecimal = 16
}


class HKZConverterBaseVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,HKZKeyboardProtocol {

    // MARK:- Properties
    let textField = UITextField()
    var models = [HKZNumberModel]()
    let mainTableView = UITableView()
    
    var baseNumType = BaseNumberType.decimal
    var keyboard = HKZKeyboard.init(frame: CGRect(), style: BaseNumberType.binary)
    let HKZNumberCellReuseId = "HKZNumberCellReuseId"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = navTitle(base: baseNumType)
        keyboard = HKZKeyboard.init(frame: CGRect(), style: baseNumType)
        
        keyboard.delegate = self
        
        mainTableView.frame = CGRect(x:0,y:0,width:kScreenWith,height:self.view.bounds.size.height)
        mainTableView.register(HKZNumberCell.self, forCellReuseIdentifier: HKZNumberCellReuseId)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        
        let headerH:CGFloat = 60.0, textfieldH:CGFloat = 30.0
        
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.frame = CGRect(x: 10.0, y: (headerH-textfieldH)/2, width: kScreenWith-20.0, height: textfieldH)
        textField.placeholder = self.textFiledPlaceHolder(base: baseNumType);
        textField.inputView = keyboard;
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWith, height: headerH))
        header.addSubview(textField)
        
        mainTableView.tableHeaderView = header
        
    }
    
    // MARK:- Private mothods
    
    func navTitle(base:BaseNumberType) -> String {
        switch base {
        case .binary:
            return "二进制"
        case .octal:
            return "八进制"
        case .decimal:
            return "十进制"
        case .hexadecimal:
            return "十六进制"
        }
    }
    
    func textFiledPlaceHolder(base:BaseNumberType) -> String {
        switch base {
        case .binary:
            return "请输入二进制数"
        case .octal:
            return "请输入八进制数"
        case .decimal:
            return "请输入十进制数"
        case .hexadecimal:
            return "请输入十六进制数"
        }
    }
    
    // 根据进制base将字符串转为数字
    func stringToNumber(string:String?, base:Int32) -> UInt {
        var endPointer:UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>!
        let value = strtoul(string, endPointer, base)
        return value
    }
    
    func convertNumber(number:String?, base:Int32) -> String {
        if (number?.isEmpty)! {
            return ""
        }
        let value = self.stringToNumber(string: number, base: baseNumType.rawValue)
        
        return String(value, radix:Int(base), uppercase:true) // 将数字按指定进制readix转为字符串
    }
    
    func listModels(base:BaseNumberType, number:String?) -> Array<HKZNumberModel> {
        let numberModel2 = HKZNumberModel(name: "二", number: convertNumber(number: number, base: 2))
        let numberModel8 = HKZNumberModel(name: "八", number: convertNumber(number: number, base: 8))
        let numberModel10 = HKZNumberModel(name: "十", number: convertNumber(number: number, base: 10))
        let numberModel16 = HKZNumberModel(name: "十六", number: convertNumber(number: number, base: 16))
        
        switch base {
        case .binary:
            return [numberModel8!,numberModel10!,numberModel16!]
        case .octal:
            return [numberModel2!,numberModel10!,numberModel16!]
        case .decimal:
            return [numberModel2!,numberModel8!,numberModel16!]
        case .hexadecimal:
            return [numberModel2!,numberModel8!,numberModel10!]
        }
    }
    
    // MARK:- UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textField.resignFirstResponder()
    }

    
    // MARK:- HKZKeyboardProtocol
    
    func HKZKeyboardEndEditing(){
        textField.resignFirstResponder()
    }
    
    func HKZKeyboardTapped(button: UIButton, number: String) {
        if (button.tag == deleteKey){
            var currentText:String? = textField.text
            if (!(currentText?.isEmpty)!) {
                currentText?.remove(at: (currentText?.index(before: (currentText?.endIndex)!))!)
                textField.text = currentText
            }
            
        }else if (button.tag == clearKey){
            textField.text = nil
        }else{
            let newNumber = textField.text?.appending(number)

            let value = self.stringToNumber(string: newNumber, base: baseNumType.rawValue)

            if (value >= UInt.max) {
                
                let alert = UIAlertController.init(title: "不能再大啦，臣妾做不到啊", message: nil, preferredStyle:UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
            textField.text = newNumber
        }
        
        let number = textField.text
        
        models = listModels(base: baseNumType, number: number)
        mainTableView.reloadData()

    }
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: HKZNumberCellReuseId) as! HKZNumberCell
        
        cell.numberModel = models[indexPath.row]
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
