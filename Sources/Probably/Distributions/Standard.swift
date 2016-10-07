import Foundation

/// A standard, explicit probability distribution with a specified set of
/// probabilities.
///
/// For a given set of probabilities, this will model those probabilities and
/// be able to compute a cumulative distribution function automatically from
/// those explicit probabilities.
struct Standard: RandomVariable, NormallyVaried {
    let values: [Double]
    let min = 0
    var max: Int {
        return values.count - 1
    }
    public func probability(of x: Int) -> Double {
        return values[x]
    }
    public func expected(_ h: (Double) -> Double) -> Double {
        // E(h(X)) = sum 0-n of h(x) * p(x)
        return values
            .enumerated()
            .reduce(0) { d, pair in
                d + (h(Double(pair.offset)) * pair.element)
        }
    }
}
