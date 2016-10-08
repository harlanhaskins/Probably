/// Represents a relation of numbers relative to the min and max of a
/// random variable
///
/// - equal: The interval consisting just of the specified number.
/// - greater: The interval of all numbers in the bounds greater than
///            the specified number.
/// - greaterOrEqual: The interval of all numbers in the bounds greater than
///                   or equal to the specified number.
/// - less: The interval of all numbers in the bounds less than
///         the specified number.
/// - lessOrEqual: The interval of all numbers in the bounds less than
///                or equal to the specified number.
/// - between: The interval of all numbers between the two specified numbers.
public enum Relation<T> where T: Strideable {
    case equal(T)
    case greater(T)
    case greaterOrEqual(T)
    case less(T)
    case lessOrEqual(T)
    case between(T, T)
    
    public func range(min: T, max: T) -> Range<T> {
        switch self {
        case let .equal(x):
            return x..<x.advanced(by: 1)
        case let .greater(x):
            return x..<max
        case let .greaterOrEqual(x):
            return x..<max.advanced(by: 1)
        case let .less(x):
            return min..<x
        case let .lessOrEqual(x):
            return min..<x.advanced(by: 1)
        case let .between(x, y):
            return x..<y
        }
    }
}
