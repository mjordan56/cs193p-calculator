//
//  BackspaceTests.swift
//  Calculator
//
//  Created by Michael Jordan on 6/20/17.
//  Copyright © 2017 MichaelJordan. All rights reserved.
//

import XCTest

class BackspaceTests: XCTestCase {
    
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
     * Test the simple case where no digits have been entered and the user taps
     * the backspace key. NOTE: The input sequence text should have a single space
     * character. This prevents the UILabel containing the input sequence from
     * being collapsed in the UI.
     */
    func testBackspaceNoDigitsEntered() {
        app.buttons["➔"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0", "Display text is incorrect.")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test backspacing a single digit.
     */
    func testBackspaceSingleDigit() {
        app.buttons["7"].tap()
        app.buttons["➔"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0", "Display text is incorrect.")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test backspacing a decimal point (period).
     */
    func testBackspaceDecimalPoint() {
        app.buttons["7"].tap()
        app.buttons["."].tap()
        app.buttons["➔"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "7", "Display text is incorrect.")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test backspacing a decimal point (period) then entering more digits.
     */
    func testBackspaceDecimalPointMoreDigits() {
        app.buttons["7"].tap()
        app.buttons["."].tap()
        app.buttons["➔"].tap()
        app.buttons["9"].tap()
        app.buttons["1"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "791", "Display text is incorrect.")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test backspacing a decimal point (period) then entering more digits with
     * a decimal point.
     */
    func testBackspaceRedoDecimalPointMoreDigits() {
        app.buttons["7"].tap()
        app.buttons["."].tap()
        app.buttons["➔"].tap()
        app.buttons["9"].tap()
        app.buttons["."].tap()
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["5"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "79.125", "Display text is incorrect.")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, " ", "Input sequence text is incorrect.")
    }
    
    /**
     * Test backspacing a pending operation. This should have no effect on the
     * operation or the display text.
     */
    func testBackspaceAfterOperationEntered() {
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["➔"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "7", "Display text is incorrect.")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "7 + …", "Input sequence text is incorrect.")
    }
    
    /**
     * Test backspacing the second operand to a pending operation.
     */
    func testBackspaceSecondOperand() {
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["."].tap()
        app.buttons["2"].tap()
        app.buttons["➔"].tap()
        app.buttons["➔"].tap()
        app.buttons["➔"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0", "Display text is incorrect.")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "7 + …", "Input sequence text is incorrect.")
    }
    
    /**
     * Test backspacing a constant.
     */
    func testBackspaceConstant() {
        app.buttons["π"].tap()
        app.buttons["➔"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "3.141593", "Display text is incorrect.")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "π =", "Input sequence text is incorrect.")
    }
}
