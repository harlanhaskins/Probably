import XCTest
import Foundation
@testable import Probably

class ProbablyTests: XCTestCase {
    
    func testPoisson() {
        let p = Poisson(mean: 2)
        XCTAssertEqualWithAccuracy(p.probability(of: 2), 0.271, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.distribution(.lessThanOrEqual(to: 5)), 0.983,
                                   accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.expected(), 2.0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.variance(), 2.0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.standardDeviation(), 1.414, accuracy: 0.01)
    }
    
    func testContinuous() {
        let bertrandsProblem = Continuous(min: 0, max: M_PI_2,
                                          riemannInterval: 0.01,
                                          function: sin)
        
        // what is the probability that the random angle picked is π/4rad from 
        // the center of the circle?
        let p = bertrandsProblem.probability(of: M_PI_4)
        XCTAssertEqualWithAccuracy(p, 0, accuracy: 0.01)
        
        // what is the probability that the random angle picked is less than 
        // π/4rad from the center of the circle?
        let d = bertrandsProblem.distribution(.less(than: M_PI_4))
        XCTAssertEqualWithAccuracy(d, 0.293, accuracy: 0.01)
        
        XCTAssertEqualWithAccuracy(bertrandsProblem.expected(),   1.0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(bertrandsProblem.variance(), 0.143, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(bertrandsProblem.standardDeviation(), 0.378, accuracy: 0.01)
        
        // does the supplied function have a probability distribution of 1 over
        // its bounds?
        XCTAssertEqualWithAccuracy(bertrandsProblem.distribution(.less(than: M_PI_2)),
                                   1.0,
                                   accuracy: 0.01)
    }
    
    func testBinomial() {
        let coinToss = Binomial(population: 3, probability: 0.5)
        
        // what is the probability that 2 coin tosses are heads
        let p = coinToss.probability(of: 2)
        XCTAssertEqualWithAccuracy(p, 3.0/8.0, accuracy: 0.01)
        
        // what is the probability that 0 or 1 tosses are heads?
        let d = coinToss.distribution(.less(than: 2))
        XCTAssertEqualWithAccuracy(d, 4.0/8.0, accuracy: 0.01)
        
        // we expect 1.5 heads results
        XCTAssertEqualWithAccuracy(coinToss.expected(), 1.5, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(coinToss.variance(), 0.75, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(coinToss.standardDeviation(), 0.86, accuracy: 0.01)
    }
    
    func testHypergeometric() {
        // 20 printers. 12 injket, 8 laser. 5 picked at random.
        let printers = Hypergeometric(numberOfTrials: 5,
                                      successesInPopulation: 12,
                                      population: 20)
        
        // what is the probability that 2 printers of the 5 are inkjet
        let probability = printers.probability(of: 2)
        XCTAssertEqualWithAccuracy(probability, 0.238, accuracy: 0.01)
        
        // what is the cumulative probability that 0, 1, and 2 printers
        // are injket
        let d = printers.distribution(.less(than: 3))
        XCTAssertEqualWithAccuracy(d, 0.296, accuracy: 0.01)
        
        // what is the expected number of inkjet printers when testing 5 of them?
        XCTAssertEqualWithAccuracy(printers.expected(), 3.0, accuracy: 0.01)
        
        // what is the variance of inkjet printers when testing 5?
        XCTAssertEqualWithAccuracy(printers.variance(), 1.579, accuracy: 0.01)
    }
    
    func testNegativeBinomial() {
        // estimate the number of times I'll need to flip a coin before I get
        // 5 heads
        let flips = NegativeBinomial(requiredSuccesses: 5, probability: 0.5)
        
        let p = flips.probability(of: 5)
        
        // what is the probability I'll get 5 heads with 5 trials?
        XCTAssertEqualWithAccuracy(p, 0.123, accuracy: 0.01)
        
        // there's a 0% chance I'll hit 5 heads with 0 flips.
        XCTAssertEqualWithAccuracy(flips.probability(of: 0), 0, accuracy: 0.01)
        
        // what is the probability that I'll get 5 heads with 5-10 trials?
        XCTAssertEqualWithAccuracy(flips.distribution(.between(5, and: 10)), 0.204,
                                   accuracy: 0.01)
        
        XCTAssertEqualWithAccuracy(flips.expected(), 5.0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(flips.variance(), 10.0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(flips.standardDeviation(), 3.162, accuracy: 0.01)
    }
    
    /** Introduction to Stochastic C++ */
    
    func testDiscrete() {
        // probability of a complaint on a given weekday, starting with
        // Sunday at 0.
        let complaints = Discrete(values: [
            0.1, 0.4, 0.05, 0.2, 0.1, 0.1, 0.05
        ])
        
        // what is the probability I will get a complaint on Tuesday?
        let p = complaints.probability(of: 2)
        XCTAssertEqualWithAccuracy(p, 0.05, accuracy: 0.01)
        
        // what is the probability I will get a complaint by end of day Wednesday?
        let d = complaints.distribution(.lessThanOrEqual(to: 3))
        XCTAssertEqualWithAccuracy(d, 0.75, accuracy: 0.01)
        
        // around what day can I most expect to get complaints?
        XCTAssertEqualWithAccuracy(complaints.expected(), 2.3, accuracy: 0.01)
        
        XCTAssertEqualWithAccuracy(complaints.variance(), 3.01, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(complaints.standardDeviation(), 1.73, accuracy: 0.01)
        
        let transform: (Double) -> Double = { ($0 * 3) + 1 }
        XCTAssertEqualWithAccuracy(complaints.expected(transform), 7.9, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(complaints.variance(transform), 27.09, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(complaints.standardDeviation(transform), 5.20, accuracy: 0.01)
    }
    
    func testGaussian() {
        let p = Normal.standard
        XCTAssertEqualWithAccuracy(p.distribution(lessThan: 1.0), 0.841, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.probability(of: 1.3), 0.171, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.expected(), 0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(p.variance(), 1, accuracy: 0.01)
        
        XCTAssertEqualWithAccuracy(p.standardize(x: 100), 100, accuracy: 0.01)
        
        let dist = Normal(mean: 10, variance: M_PI)
        let s = dist.standardize(x: 8.3)
        XCTAssertEqualWithAccuracy(s, -0.96, accuracy: 0.01)
    }
    
    func testExponential() {
        do {
            let p = Exponential(scale: 2.0)
            XCTAssertEqualWithAccuracy(p.probability(of: 0.5), 0.735, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.distribution(lessThan: 0.5), 0.632, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.expected(), 0.5, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.variance(), 0.25, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.standardDeviation(), 0.5, accuracy: 0.01)
        }
        do {
            let p = Exponential(mean: 0.5)
            XCTAssertEqualWithAccuracy(p.probability(of: 0.5), 0.735, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.distribution(lessThan: 0.5), 0.632, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.expected(), 0.5, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.variance(), 0.25, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.standardDeviation(), 0.5, accuracy: 0.01)
        }
        do {
            let p = Exponential(variance: 0.25)
            XCTAssertEqualWithAccuracy(p.probability(of: 0.5), 0.735, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.distribution(lessThan: 0.5), 0.632, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.expected(), 0.5, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.variance(), 0.25, accuracy: 0.01)
            XCTAssertEqualWithAccuracy(p.standardDeviation(), 0.5, accuracy: 0.01)
        }
    }
    
    func testRelations() {
        let r: (Relation<Double>) -> Range<Double> = {
            $0.range(min: 0, max: 10)
        }
        XCTAssertEqual(r(.less(than: 5.0)), 0..<5)
        XCTAssertEqual(r(.lessThanOrEqual(to: 5.0)), 0.0..<6.0)
        XCTAssertEqual(r(.greater(than: 5.0)), 6.0..<11.0)
        XCTAssertEqual(r(.greaterThanOrEqual(to: 5.0)), 5.0..<11.0)
        XCTAssertEqual(r(.equal(to: 5.0)), 5.0..<6.0)
        XCTAssertEqual(r(.between(5.0, and: 7.0)), 5.0..<7.0)
    }
    
    func testApproximateEquality() {
        XCTAssert(1.0 ~== (10.0 / 10.0))
        XCTAssert(0.33333333 ~== (1.0 / 3.0))
        XCTAssert(2.5 ~== (5.0 / 2.0))
    }

    #if !(os(macOS) || os(iOS) || os(tvOS) || os(watchOS))
    static var allTests : [(String, (ProbablyTests) -> () throws -> Void)] {
        return [
            ("testPoisson", testPoisson),
            ("testContinuous", testContinuous),
            ("testHypergeometric", testHypergeometric),
            ("testBinomial", testBinomial),
            ("testGaussian", testGaussian),
            ("testDiscrete", testDiscrete),
            ("testRelations", testRelations)
        ]
    }
    #endif
}
