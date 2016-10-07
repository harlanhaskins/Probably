public struct Hypergeometric: Distribution {
    public let numberOfTrials: Int
    public let requiredSuccesses: Int
    public let population: Int
    
    public let min: Int = 0
    public var max: Int {
        return numberOfTrials
    }
    
    public func probability(of x: Int) -> Double {
        let numer = Double(requiredSuccesses.choose(x) *
            (population - requiredSuccesses).choose(numberOfTrials - x))
        let denom = Double(population.choose(numberOfTrials))
        return numer / denom
    }
    
    public func expected() -> Double {
        return Double(numberOfTrials) * (Double(requiredSuccesses) / Double(population))
    }
    
    public func variance() -> Double {
        let M = Double(requiredSuccesses)
        let n = Double(numberOfTrials)
        let N = Double(population)
        return ((N-n)/(N-1)) * n * (1 - (M/N))
    }
}
