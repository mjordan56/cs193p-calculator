//
//  InputSequenceTests.swift
//  Calculator
//
//  Created by Michael Jordan on 6/16/17.
//  Copyright © 2017 MichaelJordan. All rights reserved.
//

import XCTest

class InputSequenceTests: XCTestCase {
    
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
     * Test to verify the display and input sequence text showing in the calculator.
     * This test corresponds to the CS193p assignment 1 required task number 7. The
     * test verifies the require text displays as defined in bullet items a thru k
     * in the task requirement.
     */
    func testInputSequenceDescription() {
        
        // a. touching 7 + would show "7 + …" (with 7 still in the display)
        //
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        
        var displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "7", "Display text is incorrect.")
        
        var inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "7 + …", "Input sequence text is incorrect.")
        
        // b. 7 + 9 would show "7 + …" (9 in the display)
        //
        app.buttons["9"].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "9", "Display text is incorrect.")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "7 + …", "Input sequence text is incorrect.")
        
        // c. 7 + 9 = would show "7 + 9 =" (16 in the display)
        //
        app.buttons["="].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "16", "Display text is incorrect.")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "7 + 9 =", "Input sequence text is incorrect.")
        
        // d. 7 + 9 = √ would show "√(7 + 9) =" (4 in the display)
        //
        app.buttons["√"].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "4", "Display text is incorrect.")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "√(7 + 9) =", "Input sequence text is incorrect.")
        
        // e. 7 + 9 = √ + 2 = would show "√(7 + 9) + 2 =" (6 in the display)
        //
        app.buttons["+"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "6", "Display text is incorrect.")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "√(7 + 9) + 2 =", "Input sequence text is incorrect.")
        
        // f. 7 + 9 √ would show "7 + √(9)" (3 in the display)
        // NOTE: This step does not build from the previous entries and requires a "clear"
        //
        app.buttons["C"].tap()
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["√"].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "3", "Display text is incorrect.")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "7 + √(9) …", "Input sequence text is incorrect.")

        // g. 7 + 9 √ = would show "7 + √(9)=" (3 in the display)
        //
        app.buttons["="].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "10", "Display text is incorrect.")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "7 + √(9) =", "Input sequence text is incorrect.")

        // h. 7 + 9 = + 6 = + 3 = would show "7 + 9 + 6 + 3=" (25 in the display)
        // NOTE: This step does not build from the previous entries and requires a "clear"
        //
        app.buttons["C"].tap()
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "25", "Display text is incorrect.")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "7 + 9 + 6 + 3 =", "Input sequence text is incorrect.")
        
        // i. 7 + 9 = √ 6 + 3 = would show "6 + 3 =" (9 in the display)
        // NOTE: This step does not build from the previous entries and requires a "clear"
        //
        app.buttons["C"].tap()
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        app.buttons["√"].tap()
        app.buttons["6"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "9", "Display text is incorrect.")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "6 + 3 =", "Input sequence text is incorrect.")
        
        // j. 5 + 6 = 7 3 would show "5 + 6 =" (73 in the display)
        // NOTE: This step does not build from the previous entries and requires a "clear"
        //
        app.buttons["C"].tap()
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        app.buttons["7"].tap()
        app.buttons["3"].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "73", "Display text is incorrect.")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "5 + 6 =", "Input sequence text is incorrect.")
        
        // k. 4 × π = would show "4 × π =" (12.5663706143592 in the display)
        // NOTE: This step does not build from the previous entries and requires a "clear"
        //
        app.buttons["C"].tap()
        app.buttons["4"].tap()
        app.buttons["×"].tap()
        app.buttons["π"].tap()
        app.buttons["="].tap()
        
        displayText = displayTextElement.label as String
        XCTAssertEqual(displayText, "12.566371", "Display text is incorrect.")
        
        inputSequenceText = inputSequenceTextElement.label as String
        XCTAssertEqual(inputSequenceText, "4 × π =", "Input sequence text is incorrect.")
    }
}
