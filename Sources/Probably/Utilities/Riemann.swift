import Foundation

internal func riemannSum(range: Range<Double>,
                         min: Double,
                         max: Double,
                         interval: Double = 0,
                         function: (Double) -> Double) -> Double {
    var sum = 0.0
    var lower = range.lowerBound
    let upper = Swift.min(max, range.upperBound)
    while lower <= upper {
        let value = function(lower)
        sum += value * interval
        lower += interval
    }
    return sum
}
