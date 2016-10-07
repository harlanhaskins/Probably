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
        if self == 0 {
            return 1
        }
        return (1..<self).reduce(1, *)
    }
}
