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

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation
        // of each test method in the class.
        app = XCUIApplication()
        displayTextElement = app.staticTexts["displayField"]
        
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
    }
    
    func testClearWhenCalculatorInInitialState() {
        app.buttons["C"].tap()
        let displayText = displayTextElement.label as String
        XCTAssert(displayText == "0")
    }
    
    func testClearWhileEnteringFirstOperand() {
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["C"].tap()
        let displayText = displayTextElement.label as String
        XCTAssert(displayText == "0")
    }
    
    func testClearAfterStartingFloatingPointOperand() {
        app.buttons["."].tap()
        app.buttons["C"].tap()
        let displayText = displayTextElement.label as String
        XCTAssert(displayText == "0")
    }

    func testClearAfterEnteringConstant() {
        app.buttons["π"].tap()
        app.buttons["C"].tap()
        let displayText = displayTextElement.label as String
        XCTAssert(displayText == "0")
    }
    
    func testClearAfterEnteringUnaryOperation() {
        app.buttons["2"].tap()
        app.buttons["x²"].tap()
        app.buttons["C"].tap()
        let displayText = displayTextElement.label as String
        XCTAssert(displayText == "0")
    }
    
    func testClearAfterEnteringBinaryOperation() {
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["+"].tap()
        app.buttons["C"].tap()
        let displayText = displayTextElement.label as String
        XCTAssert(displayText == "0")
    }
    
    func testClearAfterEnteringBinaryOperationThenUnaryOperation() {
        app.buttons["π"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app.buttons["sin"].tap()
        app.buttons["C"].tap()
        let displayText = displayTextElement.label as String
        XCTAssert(displayText == "0")
    }
    
    func testClearFollowedByEnteringNewFirstOperand() {
        app.buttons["."].tap()
        app.buttons["C"].tap()
        var displayText = displayTextElement.label as String
        XCTAssert(displayText == "0")
        
        app.buttons["2"].tap()
        app.buttons["5"].tap()
        app.buttons["6"].tap()
        app.buttons["."].tap()
        app.buttons["C"].tap()
        displayText = displayTextElement.label as String
        XCTAssert(displayText == "0")
    }
    
}
