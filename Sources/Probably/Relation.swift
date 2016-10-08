/// Represents a relation of numbers relative to the min and max of a
/// random variable
///
/// - equal: The interval consisting just of the specified number.
/// - greater: The interval of all numbers in the bounds greater than
///            the specified number.
/// - greaterThanOrEqual: The interval of all numbers in the bounds greater than
///                       or equal to the specified number.
/// - less: The interval of all numbers in the bounds less than
///         the specified number.
/// - lessThanOrEqual: The interval of all numbers in the bounds less than
///                    or equal to the specified number.
/// - between: The interval of all numbers between the two specified numbers.
public enum Relation<T> where T: Strideable {
    case equal(to: T)
    case greater(than: T)
    case greaterThanOrEqual(to: T)
    case less(than: T)
    case lessThanOrEqual(to: T)
    case between(T, and: T)
    
    
    /// The interval that this represents, as a Range
    ///
    /// - parameters:
    ///   - min: The minimum bound, used for `less than` calculations
    ///   - max: The maximum bound, used for `greater than` calculations.
    /// - returns: A Range of values that this relation can represent, taking
    ///            the min and max into account.
    public func range(min: T, max: T) -> Range<T> {
        switch self {
        case let .equal(x):
            return x..<x.advanced(by: 1)
        case let .greater(x):
            return x.advanced(by: 1)..<max.advanced(by: 1)
        case let .greaterThanOrEqual(x):
            return x..<max.advanced(by: 1)
        case let .less(x):
            return min..<x
        case let .lessThanOrEqual(x):
            return min..<x.advanced(by: 1)
        case let .between(x, y):
            return x..<y
        }
    }
}
