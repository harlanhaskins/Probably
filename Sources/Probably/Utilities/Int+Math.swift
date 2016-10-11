extension Int {
    /// Computes the combinations of the receiver and the parameter
    ///
    /// - parameter k: The number to choose from the receiver
    /// - returns: The number of combinations of the receiver and `k`
    func choose(_ k: Int) -> Int {
        precondition(k < self, "cannot choose more than the receiver")
        var result = 1
        for i in 0..<k {
            result *= (self - i)
            result /= (i + 1)
        }
        return result
    }
}
