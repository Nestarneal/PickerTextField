//
//  PickerTextFieldTests.swift
//  PickerTextFieldTests
//
//  Created by Nestarneal on 2018/05/18.
//  Copyright © 2018年 Nestarneal. All rights reserved.
//

import XCTest
@testable import PickerTextField

class PickerTextFieldTests: XCTestCase {
    
    private var dataSet = [String]()
    var pickerTextField: PickerTextField? = PickerTextField()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        pickerTextField = nil
        super.tearDown()
    }
    
    func testInstantiateCustomView() {
        XCTAssertNotNil(pickerTextField)
    }
    
    func testEmptyData() {
        XCTAssertNotNil(pickerTextField)
        
        pickerTextField!.dataSource = self
        XCTAssertNotNil(pickerTextField!.dataSource)
        
        dataSet = generatePseudoDataSet(withNumber: 0)
        XCTAssertEqual(pickerTextField!.dataSource!.numberOfRows(in: pickerTextField!), dataSet.count)
    }
    
    
    func testSingleData() {
        XCTAssertNotNil(pickerTextField)
        
        pickerTextField!.dataSource = self
        XCTAssertNotNil(pickerTextField!.dataSource)
        
        dataSet = generatePseudoDataSet(withNumber: 1)
        XCTAssertEqual(pickerTextField!.dataSource!.numberOfRows(in: pickerTextField!), dataSet.count)
        
        XCTAssertNotNil(pickerTextField!.dataSource!.pickerTextField(pickerTextField!, titleForRow: 0))
        XCTAssertEqual(pickerTextField!.dataSource!.pickerTextField(pickerTextField!, titleForRow: 0)!, dataSet[0])
    }
    
    func testMultipleData() {
        XCTAssertNotNil(pickerTextField)
        
        pickerTextField!.dataSource = self
        XCTAssertNotNil(pickerTextField!.dataSource)
        
        for i in 2..<10 {
            dataSet = generatePseudoDataSet(withNumber: i)
            XCTAssertEqual(pickerTextField!.dataSource!.numberOfRows(in: pickerTextField!), dataSet.count)
            
            for j in 0..<i {
                XCTAssertNotNil(pickerTextField!.dataSource!.pickerTextField(pickerTextField!, titleForRow: j))
                XCTAssertEqual(pickerTextField!.dataSource!.pickerTextField(pickerTextField!, titleForRow: j)!, dataSet[j])
            }
        }
    }
}

extension PickerTextFieldTests: PickerTextFieldDataSource {
    
    private func generatePseudoDataSet(withNumber number: Int) -> [String] {
        
        if number <= 0 {
            return [String]()
        } else {
            var result = [String]()
            for i in 0..<number {
                result.append("Data \(i)")
            }
            return result
        }
    }
    
    func numberOfRows(in pickerTextField: PickerTextField) -> Int {
        return dataSet.count
    }
    
    func pickerTextField(_ pickerTextField: PickerTextField, titleForRow row: Int) -> String? {
        return dataSet[row]
    }
}
