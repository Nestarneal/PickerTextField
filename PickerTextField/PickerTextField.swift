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

enum PickerTextFieldError: String, Error {
    case emptyDataSourceError = "Data source is not set."
    case inValidIndexError = "Index value index."
}

public class PickerTextField: UITextField {
    
    // MARK: - Properties
    
    private let toolBar = UIToolbar()
    private let pickerView = UIPickerView()
    
    @IBOutlet public weak var dataSource: PickerTextFieldDataSource?
    
    private var previousSelectedRow: Int = 0
    
    private var defaultPlaceHolder = "--"
    
    // MARK: - Interfaces.
    
    public func selectedIndex() -> Int? {
        return (previousSelectedRow == 0) ? nil : (previousSelectedRow - 1)
    }
    
    public func setIndexSelect(_ index: Int) throws {
        
        if dataSource == nil {
            throw PickerTextFieldError.emptyDataSourceError
        }
        
        if (index < 0) || (index >= dataSource!.numberOfRows(in: self)) {
            throw PickerTextFieldError.inValidIndexError
        }
        
        text = dataSource!.pickerTextField(self, titleForRow: index)
        previousSelectedRow = index + 1
    }
    
    public func reload() {
        pickerView.reloadAllComponents()
    }
    
    public func deselect() {
        previousSelectedRow = 0
        text = defaultPlaceHolder
        pickerView.selectRow(0, inComponent: 0, animated: true)
    }
    
    public func refreshTextBasedOnSelectedIndex() throws {
        
        if previousSelectedRow == 0 {
            text = defaultPlaceHolder
        }
        
        guard let dataSource = dataSource else {
            throw PickerTextFieldError.emptyDataSourceError
        }
        
        text = dataSource.pickerTextField(self, titleForRow: previousSelectedRow - 1)
    }
    
    // MARK: - Actions
    
    @objc private func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
        resignFirstResponder()
        
        previousSelectedRow = pickerView.selectedRow(inComponent: 0)
        
        if previousSelectedRow == 0 {
            text = defaultPlaceHolder
            return
        }
        
        guard let dataSource = dataSource else {
            text = nil
            return
        }
        
        text = (dataSource.numberOfRows(in: self) > 0) ? dataSource.pickerTextField(self, titleForRow: previousSelectedRow - 1) : nil
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
        
        // Set default place holder text.
        text = defaultPlaceHolder
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
        return max(dataSource.numberOfRows(in: self), 0) + 1
    }
}

// MARK: - UIPickerViewDelegate

extension PickerTextField: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return defaultPlaceHolder
        }
        guard let dataSource = dataSource else { return nil }
        return (dataSource.numberOfRows(in: self) > 0) ? dataSource.pickerTextField(self, titleForRow: row - 1) : nil
    }
}

// MARK: - UITextFieldDelegate

extension PickerTextField: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pickerView.selectRow(previousSelectedRow, inComponent: 0, animated: true)
        return true
    }
}
