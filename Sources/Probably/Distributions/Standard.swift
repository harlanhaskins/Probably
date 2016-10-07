import Foundation

struct Standard: Distribution {
    let values: [Double]
    let min = 0
    var max: Int {
        return values.count - 1
    }
    public func probability(of x: Int) -> Double {
        return values[x]
    }
    public func expected() -> Double {
        return expected { $0 }
    }
    public func expected(_ h: ((Double) -> Double)) -> Double {
        // E(h(X)) = sum 0-n of h(x) * p(x)
        return values
            .enumerated()
            .reduce(0) { d, pair in
                d + (h(Double(pair.offset)) * pair.element)
        }
    }
    public func variance() -> Double {
        // V(X) = E(X²) - E(X)²
        let exp = expected()
        let squared = expected { pow($0, 2) }
        return squared - (exp*exp)
    }
}
