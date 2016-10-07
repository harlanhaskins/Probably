import XCTest
@testable import Probably

class ProbablyTests: XCTestCase {
    
    func testPoisson() {
        let p = Poisson(mu: 2)
        XCTAssertEqualWithAccuracy(p.probability(of: 2), 0.541, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.distribution(.lessOrEqual(5)), 2.03, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.variance(), 2.0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.standardDeviation(), 1.414, accuracy: 0.01)
    }

    static var allTests : [(String, (ProbablyTests) -> () throws -> Void)] {
        return [
            ("testPoisson", testPoisson),
        ]
    }
}
