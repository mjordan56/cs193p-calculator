//
//  UnaryOperatorTests.swift
//  Calculator
//
//  Created by Michael Jordan on 3/23/17.
//  Copyright © 2017 MichaelJordan. All rights reserved.
//

import XCTest

class UnaryOperatorTests: XCTestCase {
    
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
     * Test the square root operation.
     */
    func testSquareRootOperation() {
        // Square root of an integer with integer result.
        app.buttons["9"].tap()
        app.buttons["√"].tap()
        app.buttons["="].tap()
        
        var displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "3")
        
        var inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "√(9) =", "Input sequence text is incorrect.")
        
        // Square root of an real number with real number result.
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["."].tap()
        app.buttons["2"].tap()
        app.buttons["5"].tap()
        app.buttons["√"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "3.5")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "√(12.25) =", "Input sequence text is incorrect.")
    }
    
    /**
     * Test the square operation.
     */
    func testSquareOperation() {
        // Square root of an integer with integer result.
        app.buttons["9"].tap()
        app.buttons["x²"].tap()
        app.buttons["="].tap()
        
        var displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "81")
        
        var inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "x²(9) =", "Input sequence text is incorrect.")
        
        // Square root of an real number with real number result.
        app.buttons["3"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["x²"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "12.25")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "x²(3.5) =", "Input sequence text is incorrect.")
    }
    
    /**
     * Test the sine operation.
     */
    func testSineOperation() {
        // Sine of Pi over 2.
        app.buttons["π"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        app.buttons["sin"].tap()
        
        let displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "1")
        
        let inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "sin(π ÷ 2) =", "Input sequence text is incorrect.")
        
//        // Sine of Pi over 2.
//        app.buttons["π"].tap()
//        app.buttons["÷"].tap()
//        app.buttons["2"].tap()
//        app.buttons["="].tap()
//        app.buttons["sin"].tap()
//        
//        var displayTextField = app.staticTexts["displayField"].label as String
//        XCTAssertEqual(displayTextField, "1")
//        
//        var inputSequenceText = inputSequenceTextElement.label as String
//        XCTAssertEqual(inputSequenceText, "sin(π ÷ 2) =", "Input sequence text is incorrect.")
//        
//        // Change the sign back.
//        app.buttons["±"].tap()
//        app.buttons["="].tap()
//        
//        displayTextField = app.staticTexts["displayField"].label as String
//        XCTAssertEqual(displayTextField, "9")
//        
//        inputSequenceText = inputSequenceTextElement.label as String
//        XCTAssertEqual(inputSequenceText, "±(±(9)) =", "Input sequence text is incorrect.")
    }
    
    /**
     * Test the cosine operation.
     */
    func testCosineOperation() {
    }
    
    /**
     * Test the tangent operation.
     */
    func testTangentOperation() {
    }
    
    /**
     * Test the log operation.
     */
    func testLogOperation() {
    }
    
    /**
     * Test the natural log operation.
     */
    func testNaturalLogOperation() {
    }
    
    /**
     * Test the change sign operation.
     */
    func testChangeSignOperation() {
        // Change the sign of an integer.
        app.buttons["9"].tap()
        app.buttons["±"].tap()
        app.buttons["="].tap()
        
        var displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "-9")
        
        var inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "±(9) =", "Input sequence text is incorrect.")
        
        // Change the sign back.
        app.buttons["±"].tap()
        app.buttons["="].tap()
        
        displayTextField = app.staticTexts["displayField"].label as String
        XCTAssertEqual(displayTextField, "9")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "±(±(9)) =", "Input sequence text is incorrect.")
    }
}
