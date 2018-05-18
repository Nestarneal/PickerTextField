//
//  PickerTextField.swift
//  PickerTextField
//
//  Created by Nestarneal on 2018/05/18.
//  Copyright © 2018年 Nestarneal. All rights reserved.
//

import UIKit

@objc public protocol PickerTextFieldDataSource: class {
    func numberOfRows(in pickerTextField: PickerTextField) -> Int
    func pickerTextField(_ pickerTextField: PickerTextField, titleForRow row: Int) -> String?
}

public class PickerTextField: UITextField {
    
    // MARK: - Properties
    
    private let toolBar = UIToolbar()
    private let pickerView = UIPickerView()
    
    @IBOutlet public weak var dataSource: PickerTextFieldDataSource?
    
    private var previousSelectedRow: Int = 0
    
    // MARK: - Actions
    
    @objc private func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        resignFirstResponder()
        
        previousSelectedRow = pickerView.selectedRow(inComponent: 0)
        
        guard let dataSource = dataSource else {
            text = nil
            return
        }
        
        text = (dataSource.numberOfRows(in: self) > 0) ? dataSource.pickerTextField(self, titleForRow: previousSelectedRow) : nil
    }
    
    @objc private func cancelBarButtonItemPressed(sender: UIBarButtonItem) {
        resignFirstResponder()
    }
    
    // MARK: - Initializations
    
    private func setUp() {
        // Set up the picker view.
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
        inputView = pickerView
        
        // Set up the tool bar with bar button items.
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBarButtonItemPressed(sender:)))
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBarButtonItemPressed(sender:)))
        let flexibleBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [cancelBarButtonItem, flexibleBarButtonItem, doneBarButtonItem]
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
        
        // Set up text field delegate.
        delegate = self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
}

// MARK: - UIPickerViewDataSource

extension PickerTextField: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        return max(dataSource.numberOfRows(in: self), 0)
    }
}

// MARK: - UIPickerViewDelegate

extension PickerTextField: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let dataSource = dataSource else { return nil }
        return (dataSource.numberOfRows(in: self) > 0) ? dataSource.pickerTextField(self, titleForRow: row) : nil
    }
}

// MARK: - UITextFieldDelegate

extension PickerTextField: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pickerView.selectRow(previousSelectedRow, inComponent: 0, animated: true)
        return true
    }
}
