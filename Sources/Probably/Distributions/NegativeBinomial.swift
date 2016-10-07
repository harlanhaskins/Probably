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
/// let distribution = NegativeBinomial(requiredSuccesses: 3, p: 0.55)
/// let probability = distribution.probability(of: 4)
/// // probability is 5.63%
/// ```
public struct NegativeBinomial: Distribution {
    public typealias Interval = Int
    public let requiredSuccesses: Int
    public let p: Double
    
    public let min = 0
    public var max: Int {
        return requiredSuccesses
    }
    
    public func probability(of x: Int) -> Double {
        return Double((x + requiredSuccesses - 1).choose(requiredSuccesses-1)) *
            pow(p, Double(x)) *
            pow(1-p, Double(x))
    }
    public func expected() -> Double {
        return (Double(requiredSuccesses) * (1.0 - p)) / p
    }
    
    public func variance() -> Double {
        return (Double(requiredSuccesses) * (1.0 - p)) / pow(p, 2)
    }
}
