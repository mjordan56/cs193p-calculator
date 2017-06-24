//
//  ClearAndResetCalculatorTests.swift
//  Calculator
//
//  Created by Michael Jordan on 3/23/17.
//  Copyright © 2017 MichaelJordan. All rights reserved.
//

import XCTest

class ClearAndResetCalculatorTests: XCTestCase {
    
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
        // Put teardown code here. This method is called after the invocation of
        // each test method in the class.
        super.tearDown()
        
        app = nil
        displayTextElement = nil
        inputSequenceTextElement = nil
    }
    
    /**
     * Test clearing at initial state of calculator.
     */
    func testClearWhenCalculatorInInitialState() {
        app.buttons["C"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test clearing after entering an operand.
     */
    func testClearWhileEnteringFirstOperand() {
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["C"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test clearing after starting a real number fractional portion.
     */
    func testClearAfterStartingFloatingPointOperand() {
        app.buttons["."].tap()
        app.buttons["C"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }

    /**
     * Test clearing after entering a constant.
     */
    func testClearAfterEnteringConstant() {
        app.buttons["π"].tap()
        app.buttons["C"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test clearing after entering a unary operation.
     */
    func testClearAfterEnteringUnaryOperation() {
        app.buttons["2"].tap()
        app.buttons["x²"].tap()
        app.buttons["C"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test clearing after entering a binary operation.
     */
    func testClearAfterEnteringBinaryOperation() {
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["+"].tap()
        app.buttons["C"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test clearing after entering a binary operation followed by a unary
     * operation.
     */
    func testClearAfterEnteringBinaryOperationThenUnaryOperation() {
        app.buttons["π"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app.buttons["sin"].tap()
        app.buttons["C"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test starting a decimal value entry, clearing then entering a new value
     * and clearing again.
     */
    func testClearFollowedByEnteringNewFirstOperand() {
        app.buttons["."].tap()
        app.buttons["C"].tap()
        
        var displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0")
        
        var inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
        
        app.buttons["2"].tap()
        app.buttons["5"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["C"].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
}
