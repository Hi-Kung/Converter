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



class HKZConverterBaseVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {

    // MARK: Properties
    let textField = UITextField()
    var models = [HKZNumberModel]()
    let mainTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

    
//        let tableViewH = kScreenHeight-kStatusBarHeight-kNavigationBarHeight-kTabbarHeight
        
        mainTableView.frame = CGRect(x:0,y:0,width:kScreenWith,height:self.view.bounds.size.height)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        self.view.addSubview(mainTableView)
        
        let headerH:CGFloat = 60.0, textfieldH:CGFloat = 30.0
        
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.frame = CGRect(x: 10.0, y: (headerH-textfieldH)/2, width: kScreenWith-20.0, height: textfieldH)
        textField.placeholder = "please input number";
//        textField.keyboardType = .numberPad
        textField.inputView = keyboard;
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWith, height: headerH))
        header.addSubview(textField)
        
        mainTableView.tableHeaderView = header
        
        let number1Model = HKZNumberModel(name: "八", number: "3434")
        let number2Model = HKZNumberModel(name: "十", number: "3434")
        let number3Model = HKZNumberModel(name: "十六", number: "34sd34")
        models = [number1Model!,number2Model!,number3Model!]

        mainTableView.reloadData()
        

        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textField.resignFirstResponder()
    }
    
    // MARK:UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let number = textField.text?.appending(string)
        let number1Model = HKZNumberModel(name: "八", number: number!)
        let number2Model = HKZNumberModel(name: "十", number: number!)
        let number3Model = HKZNumberModel(name: "十六", number: number!)
        models = [number1Model!,number2Model!,number3Model!]
        mainTableView.reloadData()
        return true
    }

    
    
    // MARK:UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "HKZNumberCell"
//        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//        if cell! == nil {
           let cell = HKZNumberCell(style: .default, reuseIdentifier: identifier)
//        }
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? HKZNumberCell  else {
//            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
//        }
//        let c = cell as! HKZNumberCell
        
        cell.numberModel = models[indexPath.row]
        return cell;
    }

}
