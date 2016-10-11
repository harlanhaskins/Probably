import Foundation

/// A continuous distribution.
///
/// For an arbitrary function for which all values in a given interval sum to 1,
/// a continuous distribution will model the probability of a range of numbers
/// within the domain of the function.
///
/// Essentially, the probability of values in a given interval is the integral
/// of that function over that interval.
///
/// - note: The function used to create a continuous distribution must sum to
///         1 over the bounds of the distribution. You can test this by checking
///         `probability.distribution(.less(upperBound)) ~== 1.0`
public struct Continuous: RandomVariable, Transformable {
    public let min: Double
    public let max: Double
    
    
    /// The interval used to compute the integral of the provided function.
    /// Set this to a smaller number if you need greater precision in
    /// the distribution. Default is 0.01.
    public let riemannInterval: Double
    
    /// The function that provides the probability for this distribution.
    /// - note: This function MUST sum to 1 over the `min` and `max`.
    ///         Failure to do so is a serious error and will produce
    ///         incorrect probability distributions.
    public let function: (Double) -> Double
    
    /// For a continuous distribution, the probability of a single value is
    /// always zero. You must check the probability distribution over a
    /// given interval.
    public func probability(of x: Double) -> Double {
        return 0
    }
    
    public init(min: Double,
                max: Double,
                riemannInterval: Double = 0.01,
                function: @escaping (Double) -> Double) {
        self.min = min
        self.max = max
        self.riemannInterval = riemannInterval
        self.function = function
    }
    
    public func distribution(_ relation: Relation<Double>) -> Double {
        let range = relation.range(min: min, max: max)
        return riemannSum(range: range,
                          min: min, max: max,
                          interval: riemannInterval,
                          function: function)
    }
    
    public func expected(_ h: (Double) -> Double) -> Double {
        return riemannSum(range: min..<max,
                          min: min,
                          max: max,
                          interval: riemannInterval) { x in
            h(x) * function(x)
        }
    }
    
    public func variance(_ h: (Double) -> Double) -> Double {
        let exp = expected(h)
        return riemannSum(range: min..<max,
                          min: min,
                          max: max,
                          interval: riemannInterval) { x in
            pow(x - exp, 2) * function(x)
        }
    }
}

infix operator ~==: ComparisonPrecedence

/// Tells whether two doubles are approximately equal
///
/// - parameters:
///   - lhs: The first Double to check
///   - rhs: The second Double to check
/// - returns: `true` if both Doubles are within `0.001` of each other
public func ~==(lhs: Double, rhs: Double) -> Bool {
    return abs(lhs - rhs) < 0.001
}
