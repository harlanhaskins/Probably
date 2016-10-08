import XCTest
@testable import Probably

class ProbablyTests: XCTestCase {
    
    func testPoisson() {
        let p = Poisson(mu: 2)
        XCTAssertEqualWithAccuracy(p.probability(of: 2), 0.271, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.distribution(.lessOrEqual(5)), 0.983, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.variance(), 2.0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.standardDeviation(), 1.414, accuracy: 0.01)
    }
    
    func testContinuous() {
        let bertrandsProblem = Continuous(min: 0, max: M_PI_2,
                                          riemannInterval: 0.01) { x in
            return sin(x)
        }
        let p = bertrandsProblem.distribution(.less(M_PI_4))
        XCTAssertEqualWithAccuracy(p, 0.293, accuracy: 0.01)
    }
    
    func testHypergeometric() {
        
        let distribution = Hypergeometric(numberOfTrials: 5,
                                          successesInPopulation: 12,
                                          population: 20)
        let probability = distribution.probability(of: 2)
        XCTAssertEqualWithAccuracy(probability, 0.238, accuracy: 0.01)
    }

    static var allTests : [(String, (ProbablyTests) -> () throws -> Void)] {
        return [
            ("testPoisson", testPoisson),
            ("testContinuous", testContinuous),
            ("testHypergeometric", testHypergeometric)
        ]
    }
}
