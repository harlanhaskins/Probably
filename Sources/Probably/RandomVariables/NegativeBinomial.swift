import Foundation

/// A negative binomial distribution.
///
/// For a set of trials, each of which has two outcomes S and F,
/// a negative binomial distribution demonstrates the probability that the
/// `n`th trial is the `r`th successful result.
///
/// For example, imagine there are 5 doctors. The probability that any doctor
/// recommends Orbit® gum is 55%. The probability that the 4th
/// doctor asked is the 3rd doctor that recommends Orbit® gum can be modeled
/// with a Negative Binomial distribution, like so:
/// 
/// ```
/// let distribution = NegativeBinomial(requiredSuccesses: 3, 
///                                     probability: 0.55)
/// let probability = distribution.probability(of: 4)
/// // probability is 5.63%
/// ```
public struct NegativeBinomial: RandomVariable {
    public typealias Interval = Int
    
    /// The number of successes you're aiming for
    public let requiredSuccesses: Int
    
    /// The probability of one independent trial being successful
    public let probability: Double
    
    public let min = 0
    public var max: Int {
        return requiredSuccesses
    }
    
    public func probability(of x: Interval) -> Double {
        guard x >= requiredSuccesses else { return 0 }
        return Double(x + requiredSuccesses - 1).choose(Double(requiredSuccesses - 1)) *
            pow(probability, Double(requiredSuccesses)) *
            pow(1 - probability, Double(x))
    }
    public func expected() -> Double {
        return (Double(requiredSuccesses) * probability) / (1.0 - probability)
    }
    
    public func variance() -> Double {
        return (Double(requiredSuccesses) * probability) / pow(1.0 - probability, 2)
    }
}
