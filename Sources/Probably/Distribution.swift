import Foundation

public protocol Distribution {
    associatedtype Interval
    var min: Interval { get }
    var max: Interval { get }
    func probability(of x: Interval) -> Double
    func expected() -> Double
    func variance() -> Double
    func standardDeviation() -> Double
}

public extension Distribution
    where Interval: IntegerArithmetic,
    Interval: ExpressibleByIntegerLiteral,
Interval: Strideable, Interval.Stride: SignedInteger {
    public func distribution(_ relation: Relation<Interval>) -> Double {
        return CountableRange(relation.range(min: min, max: max)).reduce(0) { d, x in
            d + probability(of: x)
        }
    }
}

public extension Distribution {
    public func standardDeviation() -> Double {
        return sqrt(variance())
    }
}
