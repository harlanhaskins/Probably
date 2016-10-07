import Foundation


/// A Poisson distribution, centered around a mean, `mu`.
public struct Poisson: Distribution {
    public typealias Interval = Int
    public let min = 0
    public let max = Int.max - 1
    private static let e = 2.7182818284590452353602
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
