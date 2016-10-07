import Foundation

public struct Continuous: Distribution {
    public let min = 0.0
    public let max = DBL_MAX
    
    public let function: (Double) -> Double
    public typealias Interval = Double
    public func probability(of x: Interval) -> Double {
        return 0
    }
    public func distribution(_ relation: Relation<Double>, riemannInterval: Double = 0.01) -> Double {
        let range = relation.range(min: min, max: max)
        return riemannSum(range: range, interval: riemannInterval)
    }
    public func expected() -> Double {
        return 0
    }
    public func variance() -> Double {
        return 0
    }
    
    private func riemannSum(range: Range<Double>, interval: Double) -> Double {
        var sum = 0.0
        var lower = range.lowerBound
        while lower <= range.upperBound {
            sum += function(lower) * interval
            lower += interval
        }
        return sum
    }
}
