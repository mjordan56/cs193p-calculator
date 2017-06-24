//
//  DecimalPointEntryTests.swift
//  Calculator
//
//  Created by Michael Jordan on 3/23/17.
//  Copyright © 2017 MichaelJordan. All rights reserved.
//

import XCTest

class DecimalPointEntryTests: XCTestCase {
    
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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        app = nil
        displayTextElement = nil
    }
    
    // NOTE: These tests do not effect the input sequence display and as such do
    // not include testing the input sequence display.
    
    /**
     * Test entering a decimal point as the first digit should retain the zero in
     * addition to showing the decimal point n the display text.
     */
    func testDecimalPointIsEnteredFirst() {
        app.buttons["."].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0.")
    }
    
    /**
     * Test entering multiple decimal points while NOT in digit entry. Successive
     * decimal should be ignored.
     */
    func testMultipleDecimalPointsAreEnteredFirst() {
        app.buttons["."].tap()
        app.buttons["."].tap()
        app.buttons["."].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0.")
    }
    
    /**
     * Test entering multiple decimal points then beginning digit entry. Successive
     * decimal should be ignored.
     */
    func testMultipleDecimalPointsAreEnteredBeforeDigits() {
        app.buttons["."].tap()
        app.buttons["."].tap()
        app.buttons["."].tap()
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "0.12")
    }
    
    /**
     * Test entering multiple decimal points during digit entry. Successive decimal
     * should be ignored.
     */
    func testMultipleDecimalPointDuringOperandEntery() {
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["."].tap()
        app.buttons["7"].tap()
        app.buttons["."].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        
        let displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "12.75")
    }
}
