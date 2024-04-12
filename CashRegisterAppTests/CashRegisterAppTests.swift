//
//  CashRegisterAppTests.swift
//  CashRegisterAppTests
//
//  Created by Brian King on 4/12/24.
//

import XCTest

@testable import  CashRegisterApp
final class CashRegisterAppTests: XCTestCase {
    
    var viewModel: RegisterViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RegisterViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPositiveChangeDue() {
        let purchasePrice = 4.00
        let cashGiven = 6.00
        
        viewModel.calculateChange(purchasePrice, cashGiven)
        
        XCTAssertTrue(viewModel.changeDue != ChangeOutputs.Zero.rawValue)
        XCTAssertTrue(viewModel.changeDue != ChangeOutputs.Insufficient.rawValue)
        XCTAssertTrue(viewModel.changeDue != ChangeOutputs.NA.rawValue)
    }
    
    func testInufficientFunds() {
        let purchasePrice = 8.00
        let cashGiven = 6.00
        
        viewModel.calculateChange(purchasePrice, cashGiven)
        
        XCTAssertTrue(viewModel.changeDue == ChangeOutputs.Insufficient.rawValue)
    }
    
    func testZeroChange() {
        let purchasePrice = 6.00
        let cashGiven = 6.00
        
        viewModel.calculateChange(purchasePrice, cashGiven)
        
        XCTAssertTrue(viewModel.changeDue == ChangeOutputs.Zero.rawValue)
    }
    
    func testChangeAccuracy() {
        let purchasePrice = 6.00
        let cashGiven = 6.10
        let testString = "DIME: 1"
        
        viewModel.calculateChange(purchasePrice, cashGiven)
        
        XCTAssertTrue(viewModel.changeDue.contains(testString))
    }
    
    func testChangeOutputsZero() {
        let zero = "Zero"
        
        XCTAssertTrue(zero == ChangeOutputs.Zero.rawValue)
    }
    
    func testChangeOutputsInsufficient() {
        let insufficient = "Insufficient Funds"
        
        XCTAssertTrue(insufficient == ChangeOutputs.Insufficient.rawValue)
    }
    
    func testChangeOutputsNA() {
        let na = "N/A"
        
        XCTAssertTrue(na == ChangeOutputs.NA.rawValue)
    }
    
    func testColorCorrelationAccuracy() {
        XCTAssertEqual(viewModel.getColorCorrelation(for: .Insufficient), .red)
        XCTAssertEqual(viewModel.getColorCorrelation(for: .Positive), .green)
        XCTAssertEqual(viewModel.getColorCorrelation(for: .Zero), .yellow)
        XCTAssertEqual(viewModel.getColorCorrelation(for: .NA), .softBlack)
    }
    
    func testChangeOutputAccuracy() {
        viewModel.changeDue = "DIME: 1"
        XCTAssertEqual(viewModel.getChangeOutput(), .Positive)
        
        viewModel.changeDue = "Zero"
        XCTAssertEqual(viewModel.getChangeOutput(), .Zero)
        
        viewModel.changeDue = "N/A"
        XCTAssertEqual(viewModel.getChangeOutput(), .NA)
        
        viewModel.changeDue = "Insufficient Funds"
        XCTAssertEqual(viewModel.getChangeOutput(), .Insufficient)
    }
    
    func testRoundedNumberHelperFunctionality() {
        let testNumber = 6.582345
        let roundedTestResult = NumberHelper().getRoundedNumberString(given: testNumber, by: 2)
        
        XCTAssertEqual(roundedTestResult, "6.58")
    }
    
    func testPerformanceOfChangeCalculation() throws {
        measure {
            // Put the code you want to measure the time of here.
            let _ = viewModel.calculateChange(2.00, 4.00)
        }
    }

}
