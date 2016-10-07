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
