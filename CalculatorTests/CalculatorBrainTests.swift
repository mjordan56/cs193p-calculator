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
        XCTAssertEqual(brain.result.value, nil)
        
        brain.setOperand(3.14159)
        brain.performOperation("/")
        brain.reset()
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, nil)

        brain.setOperand(3.14159)
        brain.performOperation("/")
        brain.setOperand(1.125)
        brain.reset()
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, nil)
    }
    
    /**
     * Tests setting the calculator brain operand.
     */
    func testSetOperand() {
        // Test setting the operand to a simple integer value.
        brain.setOperand(1)
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, 1.0)
        
        // Test setting the operand to a floating point value.
        brain.setOperand(3.125)
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, 3.125)
    }
    
    /**
     * Tests performing the unary operation to change the sign of the operand.
     */
    func testPerformUnaryOperationChangeSign() {
        // Test changing the sign of a positive floating point value to be negative.
        brain.setOperand(3.125)
        brain.performOperation("±")
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, -3.125)
        XCTAssertEqual(brain.result.description, "±(3.125)")

        // Test changing the sign of a negative floating point value to be positive.
        brain.setOperand(-3.125)
        brain.performOperation("±")
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, 3.125)
        XCTAssertEqual(brain.result.description, "±(-3.125)")
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
        XCTAssertEqual(brain.result.value, 5)
        
        // Test adding two floating point values.
        brain.setOperand(-12.5)
        brain.performOperation("+")
        brain.setOperand(22.125)
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, 9.625)
    }
    
    /**
     * Tests to verify the description of the sequence of the operands and
     * operations that led to the value returned by result. This test corresponds
     * to the CS193p assignment 1 required task number 7. The test verifies the
     * require text displays as defined in bullet items a thru k in the task requirement.
     */
    func testAccumulatorDescription() {
        
        // a. entering 7.0 + result is nil, a result is pending and input sequence
        //    is "7.0 +"
        //
        brain.setOperand(7.0)
        brain.performOperation("+")
        XCTAssert(brain.resultIsPending == true)
        XCTAssertEqual(brain.result.value, nil)
        XCTAssertEqual(brain.result.description, "7.0 +")
        
        // b. entering 9.0 result is 9.0, a result is pending and input sequence
        //    is "9.0"
        //
        brain.setOperand(9.0)
        XCTAssert(brain.resultIsPending == true)
        XCTAssertEqual(brain.result.value, 9.0)
        XCTAssertEqual(brain.result.description, "9.0")
        
        // c. entering = result is 16.0, a result is NOT pending and input
        //    sequence is "7.0 + 9.0"
        //
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, 16.0)
        XCTAssertEqual(brain.result.description, "7.0 + 9.0")
        
        // d. entering √ result is 4.0, a result is NOT pending and input
        //    sequence is "√(7.0 + 9.0)"
        //
        brain.performOperation("√")
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, 4.0)
        XCTAssertEqual(brain.result.description, "√(7.0 + 9.0)")
        
        // e. entering + 2.0 result is 6.0, a result is NOT pending and input
        //    sequence is "√(7.0 + 9.0) + 2.0"
        //
        brain.performOperation("+")
        brain.setOperand(2.0)
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, 6.0)
        XCTAssertEqual(brain.result.description, "√(7.0 + 9.0) + 2.0")
        
        // f. reset calculator, enter 7.0 + 9.0 √ result is 3.0, a result is
        //    pending and input sequence is "7.0 + √(9.0)"
        //
        brain.reset()
        brain.setOperand(7.0)
        brain.performOperation("+")
        brain.setOperand(9.0)
        brain.performOperation("√")
        XCTAssert(brain.resultIsPending == true)
        XCTAssertEqual(brain.result.value, 3.0)
        XCTAssertEqual(brain.result.description, "7.0 + √(9.0)")
        
        // g. enter = result is 10.0, a result is NOT pending and input sequence
        //    is "7.0 + √(9.0)"
        //
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, 10.0)
        XCTAssertEqual(brain.result.description, "7.0 + √(9.0)")

        // h. reset calculator, enter 7.0 + 9.0 = + 6.0 = + 3.0 = result is 25.0,
        //    a result is NOT pending and input sequence is "7.0 + 9.0 + 6.0 + 3.0"
        //
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
        XCTAssertEqual(brain.result.value, 25.0)
        XCTAssertEqual(brain.result.description, "7.0 + 9.0 + 6.0 + 3.0")
        
        // i. reset calculator, enter 7.0 + 9.0 = √ 6.0 + 3.0 = result is 9.0,
        //    a result is NOT pending and input sequence is "6.0 + 3.0"
        //
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
        XCTAssertEqual(brain.result.value, 9.0)
        XCTAssertEqual(brain.result.description, "6.0 + 3.0")
        
        // j. THIS IS A UI TEST AND DOESN'T HAVE AN EQUIVALENT MODEL TEST.

        // k. reset calculator, enter 4.0 × π = result is 12.56637061,
        //    a result is NOT pending and input sequence is "4.0 × π"
        //
        brain.reset()
        brain.setOperand(4.0)
        brain.performOperation("×")
        brain.performOperation("π")
        brain.performOperation("=")
        XCTAssert(brain.resultIsPending == false)
        XCTAssertEqual(brain.result.value, 4.0 * Double.pi)
        XCTAssertEqual(brain.result.description, "4.0 × π")
    }
}
