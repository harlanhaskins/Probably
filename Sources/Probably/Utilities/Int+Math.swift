extension Int {
    func choose(_ k: Int) -> Int {
        var result = 1
        for i in 0..<k {
            result *= (self - i)
            result /= (i + 1)
        }
        return result
    }
    var factorial: Int {
        return self < 2 ? 1 : (2...self).reduce(1, *)
    }
}
