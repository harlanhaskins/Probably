import Foundation

/// A binomial distribution with a specific probability.
///
/// For a set of trials, each of which can either pass or fail,
/// a binomial distribution represents the probability that the `n`
/// trials are successes.
///
/// For example, the probability that 3 coin tosses in a set of
/// tosses is `heads` is:
/// ```
/// let distribution = Binomial(population: 5, probability: 0.5)
/// let probability = distribution.probability(of: 3)
/// ```
public struct Binomial: RandomVariable {
    public let min = 0
    public var max: Int {
        return population
    }
    
    /// The total population being sampled
    public let population: Int
    
    /// The probability that, independently, one of the samples will
    /// be a success
    public let probability: Double
    
    public func probability(of x: Int) -> Double {
        return Double(population).choose(Double(x)) *
            (pow(probability, Double(x))) *
            pow((1 - probability), Double(population - x))
    }
    
    public func expected() -> Double {
        return Double(population) * probability
    }
    
    public func variance() -> Double {
        return expected() * (1 - probability)
    }
}
