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
///         `probability.distribution(.less(upperBound), riemannInterval: 0.01)`
public struct Continuous: RandomVariable, NormallyVaried {
    public let min: Double
    public let max: Double
    public let riemannInterval: Double
    public let function: (Double) -> Double
    
    public typealias Interval = Double
    
    public func probability(of x: Interval) -> Double {
        return 0
    }
    
    init(min: Double,
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
        return riemannSum(range: range, function: function)
    }
    
    public func expected(_ h: (Double) -> Double) -> Double {
        return riemannSum(range: min..<max) { x in
            h(x) * function(x)
        }
    }
    
    public func variance(_ h: (Double) -> Double) -> Double {
        let exp = expected(h)
        return riemannSum(range: min..<max) { x in
            pow(x - exp, 2) * function(x)
        }
    }
    
    private func riemannSum(range: Range<Double>, function: (Double) -> Double) -> Double {
        var sum = 0.0
        var lower = range.lowerBound
        let upper = Swift.min(max, range.upperBound)
        while lower <= upper {
            let value = lower >= min ? function(lower) : 0
            sum += value * riemannInterval
            lower += riemannInterval
        }
        return sum
    }
}
