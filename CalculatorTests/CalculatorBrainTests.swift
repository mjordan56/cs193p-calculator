//
//  CalculatorBrainTests.swift
//  Calculator
//
//  Created by Michael Jordan on 3/21/17.
//  Copyright © 2017 MichaelJordan. All rights reserved.
//

import XCTest

@testable import Calculator

class CalculatorBrainTests: XCTestCase {
    
    var brain:CalculatorBrain!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        brain = CalculatorBrain()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     * Tests resetting the calculator brain to an initial state.
     */
    func testCalculatorBrainReset() {
        brain.setOperand(3.14159)
        brain.reset()
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == nil)
        
        brain.setOperand(3.14159)
        brain.performOperation("/")
        brain.reset()
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == nil)

        brain.setOperand(3.14159)
        brain.performOperation("/")
        brain.setOperand(1.125)
        brain.reset()
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == nil)
    }
    
    /**
     * Tests setting the calculator brain operand.
     */
    func testSetOperand() {
        // Test setting the operand to a simple integer value.
        brain.setOperand(1)
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 1.0)
        
        // Test setting the operand to a floating point value.
        brain.setOperand(3.125)
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 3.125)
    }
    
    /**
     * Tests performing the unary operation to change the sign of the operand.
     */
    func testPerformUnaryOperationChangeSign() {
        // Test changing the sign of a positive floating point value to be negative.
        brain.setOperand(3.125)
        brain.performOperation("±")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == -3.125)
        
        // Test changing the sign of a negative floating point value to be positive.
        brain.setOperand(-3.125)
        brain.performOperation("±")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 3.125)
    }
    
    /**
     * Tests performing the binary operation to add two operands.
     */
    func testPerformBinaryOperationAddition() {
        // Test adding two integer values.
        brain.setOperand(3)
        brain.performOperation("+")
        brain.setOperand(2)
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 5)
        
        // Test adding two floating point values.
        brain.setOperand(-12.5)
        brain.performOperation("+")
        brain.setOperand(22.125)
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 9.625)
    }
    
    /**
     * Tests to verify the description of the sequence of the operands and
     * operations that led to the value returned by result.
     */
    func testAccumulatorDescription() {
        brain.setOperand(7.0)
        brain.performOperation("+")
        XCTAssert(brain.resultIsPending == true)
        XCTAssert(brain.result.value == nil)
        XCTAssert(brain.result.description == "7.0 +")
        
        brain.setOperand(9.0)
        XCTAssert(brain.resultIsPending == true)
        XCTAssert(brain.result.value == 9.0)
        XCTAssert(brain.result.description == "9.0")
        
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 16.0)
        XCTAssert(brain.result.description == "7.0 + 9.0")
        
        brain.performOperation("√")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 4.0)
        XCTAssert(brain.result.description == "√(7.0 + 9.0)")
        
        brain.performOperation("+")
        brain.setOperand(2.0)
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 6.0)
        XCTAssert(brain.result.description == "√(7.0 + 9.0) + 2.0")
        
        brain.reset()
        brain.setOperand(7.0)
        brain.performOperation("+")
        brain.setOperand(9.0)
        brain.performOperation("√")
        XCTAssert(brain.resultIsPending == true)
        XCTAssert(brain.result.value == 3.0)
        XCTAssert(brain.result.description == "7.0 + √(9.0)")
        
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 10.0)
        XCTAssert(brain.result.description == "7.0 + √(9.0)")

        brain.reset()
        brain.setOperand(7.0)
        brain.performOperation("+")
        brain.setOperand(9.0)
        brain.performOperation("=")
        brain.performOperation("+")
        brain.setOperand(6.0)
        brain.performOperation("=")
        brain.performOperation("+")
        brain.setOperand(3.0)
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 25.0)
        XCTAssert(brain.result.description == "7.0 + 9.0 + 6.0 + 3.0")
        
        brain.reset()
        brain.setOperand(7.0)
        brain.performOperation("+")
        brain.setOperand(9.0)
        brain.performOperation("=")
        brain.performOperation("√")
        brain.setOperand(6.0)
        brain.performOperation("+")
        brain.setOperand(3.0)
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 9.0)
        XCTAssert(brain.result.description == "6.0 + 3.0")

        brain.reset()
        brain.setOperand(4.0)
        brain.performOperation("×")
        brain.performOperation("π")
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssert(brain.result.value == 4.0 * Double.pi)
        XCTAssert(brain.result.description == "4.0 × π")

    }
}
