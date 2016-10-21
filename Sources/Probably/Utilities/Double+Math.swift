import Foundation

extension Double {
    /// Computes the combinations of the receiver and the parameter
    ///
    /// - parameter k: The number to choose from the receiver
    /// - returns: The number of combinations of the receiver and `k`
    func choose(_ k: Double) -> Double {
        precondition(k <= self, "cannot choose more than the receiver")
        return tgamma(self + 1) / (tgamma(k + 1) * tgamma(self - k + 1))
    }
}
