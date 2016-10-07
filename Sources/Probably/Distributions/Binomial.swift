import Foundation

/// A binomial distribution with a specific probability.
///
/// For a set of trials, each of which can either pass or fail,
/// a binomial distribution represents the probability that the `n`th
/// trial is a success.
///
/// For example, the probability that the 3rd coin toss in a set of
/// tosses is `heads` is:
/// ```
/// let distribution = Binomial(population: 3, probability: 0.5)
/// let probability = distribution.probability(of: 3)
/// ```
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
