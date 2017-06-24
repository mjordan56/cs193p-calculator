//
//  BinaryOperatorTests.swift
//  Calculator
//
//  Created by Michael Jordan on 3/23/17.
//  Copyright © 2017 MichaelJordan. All rights reserved.
//

import XCTest

class BinaryOperatorTests: XCTestCase {
    
    var app: XCUIApplication!
    
    var displayTextElement: XCUIElement!
    
    var inputSequenceTextElement: XCUIElement!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation
        // of each test method in the class.
        app = XCUIApplication()
        displayTextElement = app.staticTexts["displayField"]
        inputSequenceTextElement = app.staticTexts["inputSequenceField"]

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        app = nil
        displayTextElement = nil
        inputSequenceTextElement = nil
    }
    
    /**
     * Test the addition operator.
     */
    func testAdditionOperation() {
        // Add two integer values.
        app.buttons["8"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        
        var displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "14")
 
        var inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "8 + 6 =", "Input sequence text is incorrect.")
        
        // Add two real number values; no fractional portions.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "10")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4 + 6 =", "Input sequence text is incorrect.")
        
        // Add two real number values; first operand has fractional portion.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "10.5")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4.5 + 6 =", "Input sequence text is incorrect.")
        
        // Add two real number values; both operands have fractional portions
        // operands result is an integer value.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "11")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4.5 + 6.5 =", "Input sequence text is incorrect.")
    }
    
    func testSubtractionOperation() {
        // Subtract two integer values.
        app.buttons["8"].tap()
        app.buttons["−"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        
        var displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "2")
        
        var inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "8 − 6 =", "Input sequence text is incorrect.")
        
        // Subtract two real number values; no fractional portions.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["−"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "-2")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4 − 6 =", "Input sequence text is incorrect.")
        
        // Subtract two real number values; first operand has fractional portion.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["−"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "-1.5")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4.5 − 6 =", "Input sequence text is incorrect.")
        
        // Subtract two real number values; both operands have fractional portions
        // operands result is an integer value.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["−"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "-2")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4.5 − 6.5 =", "Input sequence text is incorrect.")
    }
    
    func testMultiplicationOperation() {
        // Multiply two integer values.
        app.buttons["8"].tap()
        app.buttons["×"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        
        var displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "48")
        
        var inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "8 × 6 =", "Input sequence text is incorrect.")
        
        // Multiply two integer values.
        app.buttons["8"].tap()
        app.buttons["±"].tap()
        app.buttons["×"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "-48")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "±(8) × 6 =", "Input sequence text is incorrect.")
        
        // Multiply two real number values; no fractional portions.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["×"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "24")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4 × 6 =", "Input sequence text is incorrect.")
        
        // Multiply two real number values; first operand has fractional portion.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["3"].tap()
        app.buttons["×"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "25.8")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4.3 × 6 =", "Input sequence text is incorrect.")
        
        // Multiply two real number values; both operands have fractional portions
        // operands result is an integer value.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["×"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "29.25")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4.5 × 6.5 =", "Input sequence text is incorrect.")
    }
    
    func testDivisionOperation() {
        // Divide two integer values.
        app.buttons["8"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        
        var displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "4")
        
        var inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "8 ÷ 2 =", "Input sequence text is incorrect.")
        
        // Divide two integer values.
        app.buttons["8"].tap()
        app.buttons["±"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "-4")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "±(8) ÷ 2 =", "Input sequence text is incorrect.")
        
        // Divide two real number values; no fractional portions.
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "3")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "6 ÷ 2 =", "Input sequence text is incorrect.")
        
        // Divide two real number values; first operand has fractional portion.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["2"].tap()
        app.buttons["÷"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "0.7")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4.2 ÷ 6 =", "Input sequence text is incorrect.")
        
        // Divide two real number values; both operands have fractional portions
        // operands result is an integer value.
        app.buttons["4"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["÷"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["2"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "0.72")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4.5 ÷ 6.25 =", "Input sequence text is incorrect.")
    }
}
