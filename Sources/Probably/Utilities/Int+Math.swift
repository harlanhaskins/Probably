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
    
    
    /// The factorial of the receiver.
    /// - note: This number must be positive.
    var factorial: Int {
        precondition(self >= 0, "argument to factorial must be positive")
        return self < 2 ? 1 : (2...self).reduce(1, *)
    }
}
