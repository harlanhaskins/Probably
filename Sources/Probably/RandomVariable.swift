import Foundation

/// An abstract notion of a probability distribution over an interval.
public protocol RandomVariable {
    /// The type that restricts the possible probability values.
    associatedtype Interval
    
    /// The minimum value this random variable can be
    var min: Interval { get }
    
    /// The maximum value this random variable can be
    var max: Interval { get }
    
    /// Computes probability that a given value is the result of
    /// this random variable.
    ///
    /// - parameter x: The value you're intending to check
    /// - returns: The probability of that value appearing in this random
    ///            variable's output
    func probability(of x: Interval) -> Double
    
    
    /// - returns: The mean of this distribution
    func expected() -> Double
    
    /// - returns: The variance of this distribution
    func variance() -> Double
    
    /// - returns: The standard deviation of this distribution
    func standardDeviation() -> Double
}

public extension RandomVariable where Interval == Int {
    
    /// The cumulative distribution for a given relation.
    ///
    /// - parameter relation: The relation you're checking, like `.less(10)`,
    ///                       `.greaterOrEqual(4)`
    /// - returns: The cumulative distribution of probability over the specified
    ///            interval.
    public func distribution(_ relation: Relation<Interval>) -> Double {
        return CountableRange(relation.range(min: min, max: max)).reduce(0) { d, x in
            d + probability(of: x)
        }
    }
}

public extension RandomVariable {
    
    /// The standard deviation of this random variable.
    /// Computed as the square root of the variance.
    ///
    /// - returns: The standard deviation from the expected value of
    ///            this variable
    public func standardDeviation() -> Double {
        return sqrt(variance())
    }
}

/// A Random Variable which can transform the expected values or variance
/// using a function.
public protocol Transformable: RandomVariable {
    func expected(_ h: (Double) -> Double) -> Double
    func variance(_ h: (Double) -> Double) -> Double
}

public extension Transformable {
    /// - returns: The mean of this distribution
    public func expected() -> Double {
        return expected { $0 }
    }
    
    /// - returns: The variance of this distribution
    public func variance() -> Double {
        return variance { $0 }
    }
    
    /// - parameter h: The transform function to apply to each step of the
    ///                distribution during calculation
    /// - returns: The variance of this distribution as a function of E(h(X)):
    /// - note: `V(h(X)) = E(h(X)²) - E(h(X))²`
    public func variance(_ h: (Double) -> Double) -> Double {
        
        let exp = expected(h)
        let squared = expected {
            let x = h($0)
            return x * x
        }
        return squared - (exp * exp)
    }
    
    public func standardDeviation(_ h: (Double) -> Double) -> Double {
        return sqrt(variance(h))
    }
}
