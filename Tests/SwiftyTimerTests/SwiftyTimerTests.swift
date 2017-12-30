import XCTest
import Foundation
import Dispatch
@testable import SwiftyTimer

class SwiftyTimerTests: XCTestCase {
    func testSwiftyTimer() {
        var timer = SwiftyTimer()
        let waitTimeNano = UInt32(100_000_000)
        let epsilonNano = UInt64(2_000_000)
        
        
        
        timer.start()
        #if os(Linux)
            usleep(waitTimeNano / 1_000)
        #else
            let expectation = XCTestExpectation()
            let deadline: DispatchTime = DispatchTime.now() + .nanoseconds(100_000_000)
            DispatchQueue.global(qos: .background).asyncAfter(deadline: deadline) {
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: TimeInterval(1.0))
        #endif
        timer.stop()
        
        print("timer nano: \(timer.nanoseconds)")
        let differenceIsAcceptable = (timer.nanoseconds - UInt64(waitTimeNano)) < epsilonNano
        XCTAssertTrue(differenceIsAcceptable , "reported elapsed time was off by greater than \(epsilonNano) nanoseconds")
        XCTAssertTrue(timer.nanoseconds == UInt64(timer.microseconds * 1_000) , "innacurate microseconds")
        XCTAssertTrue(timer.nanoseconds == UInt64(timer.milliseconds * 1_000_000), "innacurate milliseconds")
        XCTAssertTrue(timer.nanoseconds == UInt64(timer.seconds * 1_000_000_000), "innacurate seconds")
    }


    static var allTests = [
        ("testSwiftyTimer", testSwiftyTimer),
    ]
}
