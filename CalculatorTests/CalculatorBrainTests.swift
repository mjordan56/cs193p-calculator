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
        XCTAssert(brain.result == nil && !brain.resultIsPending)
        
        brain.setOperand(3.14159)
        brain.performOperation("/")
        brain.reset()
        XCTAssert(brain.result == nil && !brain.resultIsPending)

        brain.setOperand(3.14159)
        brain.performOperation("/")
        brain.setOperand(1.125)
        brain.reset()
        XCTAssert(brain.result == nil && !brain.resultIsPending)
    }
    
    /**
    * Tests setting the calculator brain operand.
    */
    func testSetOperand() {
        // Test setting the operand to a simple integer value.
        brain.setOperand(1)
        XCTAssert(brain.result == 1.0)
        
        // Test setting the operand to a floating point value.
        brain.setOperand(3.125)
        XCTAssert(brain.result == 3.125)
    }
    
    /**
    * Tests performing the unary operation to change the sign of the operand.
    */
    func testPerformUnaryOperationChangeSign() {
        // Test changing the sign of a positive floating point value to be negative.
        brain.setOperand(3.125)
        brain.performOperation("±")
        XCTAssert(brain.result == -3.125)
        
        // Test changing the sign of a negative floating point value to be positive.
        brain.setOperand(-3.125)
        brain.performOperation("±")
        XCTAssert(brain.result == 3.125)
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
        XCTAssert(brain.result == 5)
        
        // Test adding two floating point values.
        brain.setOperand(-12.5)
        brain.performOperation("+")
        brain.setOperand(22.125)
        brain.performOperation("=")
        XCTAssert(brain.result == 9.625)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
