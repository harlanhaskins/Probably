import Foundation

public struct Binomial: Distribution {
    public let min = 0
    public var max: Int {
        return population
    }
    public let population: Int
    public let probability: Double
    public func probability(of x: Int) -> Double {
        guard (0...population).contains(x) else { return 0 }
        return Double(population.choose(x)) *
            (pow(probability, Double(x))) *
            pow((1 - probability), Double(population - x))
    }
    public func expected() -> Double {
        return Double(population) * probability
    }
    public func variance() -> Double {
        return expected() * (1-probability)
    }
}
