import Foundation


/// A Poisson distribution, centered around a mean, `mu`.
/// 
/// For a given event, the Poisson distribution models probability based solely
/// on an average.
///
/// For example, the average number of students that pass a midterm stats exam
/// for a given year is 74
/// The probability that 85 students will pass this term, assuming
/// population is constant, is a Poisson probability:
/// ```
/// let poisson = Poisson(mu: 14)
/// let probability = poisson.probability(of: 18)
/// // probability is 5.5%
/// ```
public struct Poisson: RandomVariable {
    public typealias Interval = Int
    
    public let min = 0
    public let max = Int.max - 1
    
    private static let e = 2.7182818284590452353602
    
    /// The mean of probabilities over this distribution
    public let mu: Double
    
    public func probability(of x: Interval) -> Double {
        return (pow(Poisson.e, -mu) * pow(mu, Double(x))) / Double(x.factorial)
    }
    public func expected() -> Double {
        return mu
    }
    public func variance() -> Double {
        return mu
    }
}
