//
//  ViewController.swift
//  PickerTextField
//
//  Created by Nestarneal on 2018/05/19.
//  Copyright © 2018年 Nestarneal. All rights reserved.
//

import UIKit
import PickerTextField

class ViewController: UIViewController {

    @IBOutlet weak var lowerPickerTextField: PickerTextField!
    
    @IBAction func setButtonPressed(_ sender: UIButton) {
        
        do {
            try lowerPickerTextField.setIndexSelect(2)
        } catch {
            let alert = UIAlertController(title: "Fail", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @IBAction func getButtonPressed(_ sender: UIButton) {
        if let index = lowerPickerTextField.selectedIndex() {
            print("Index: \(index)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController {
    
    enum PickerTextFieldTag {
        static let upper = 1
        static let middle = 2
        static let lower = 3
    }
    
    var pseudoDataSetUpper: [String] {
        return [String]()
    }
    
    var pseudoDataSetMiddle: [String] {
        return ["A"]
    }
    
    var pseudoDataSetLower: [String] {
        return ["A", "B", "C"]
    }
}

extension ViewController: PickerTextFieldDataSource {
    func numberOfRows(in pickerTextField: PickerTextField) -> Int {
        
        switch pickerTextField.tag {
            
        case PickerTextFieldTag.upper:
            return pseudoDataSetUpper.count
            
        case PickerTextFieldTag.middle:
            return pseudoDataSetMiddle.count
            
        case PickerTextFieldTag.lower:
            return pseudoDataSetLower.count
            
        default:
            return 0
        }
    }
    
    func pickerTextField(_ pickerTextField: PickerTextField, titleForRow row: Int) -> String? {
        
        switch pickerTextField.tag {
            
        case PickerTextFieldTag.upper:
            return pseudoDataSetUpper[row]
            
        case PickerTextFieldTag.middle:
            return pseudoDataSetMiddle[row]
            
        case PickerTextFieldTag.lower:
            return pseudoDataSetLower[row]
            
        default:
            return nil
        }
    }
}
