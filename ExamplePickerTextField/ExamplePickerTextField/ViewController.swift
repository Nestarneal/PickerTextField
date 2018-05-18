//
//  ViewController.swift
//  ExamplePickerTextField
//
//  Created by Nestarneal on 2018/05/18.
//  Copyright © 2018年 Nestarneal. All rights reserved.
//

import UIKit
import PickerTextField

class ViewController: UIViewController {

    private let pseudoDataSetUpper = [String]()
    private let pseudoDataSetLower = ["Apple", "Banana", "Cat", "Dog"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: PickerTextFieldDataSource {
    
    func numberOfRows(in pickerTextField: PickerTextField) -> Int {
        
        if pickerTextField.tag == 1 {
            return pseudoDataSetUpper.count
        } else if pickerTextField.tag == 2 {
            return pseudoDataSetLower.count
        } else {
            return 0
        }
    }
    
    func pickerTextField(_ pickerTextField: PickerTextField, titleForRow row: Int) -> String? {
        
        if pickerTextField.tag == 1 {
            return pseudoDataSetUpper[row]
        } else if pickerTextField.tag == 2 {
            return pseudoDataSetLower[row]
        } else {
            return nil
        }
    }
}
