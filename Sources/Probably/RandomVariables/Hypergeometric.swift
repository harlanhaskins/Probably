/// A hypergeometric distribution.
///
/// For a set of trials, with a given population and number of successes,
/// a hypergeometric distribution represents a possibility that `n` trials are
/// all successes.
///
/// For example: You have 20 printers. 8 are laser, 12 inkjet. You select 5 of
/// them and want to know what's the probability that 2 of the 5 are inkjet.
///
/// ```
/// let distribution = Hypergeometric(numberOfTrials: 5, 
///                                   successesInPopulation: 12,
///                                   population: 20)
/// let probability = distribution.probability(of: 2)
/// // probability is 23.8%
/// ```
public struct Hypergeometric: RandomVariable {
    public let numberOfTrials: Int
    public let successesInPopulation: Int
    public let population: Int
    
    public let min: Int = 0
    public var max: Int {
        return numberOfTrials
    }
    
    public func probability(of x: Int) -> Double {
        let numer = Double(successesInPopulation).choose(Double(x)) *
            (Double(population - successesInPopulation)).choose(Double(numberOfTrials - x))
        let denom = Double(population).choose(Double(numberOfTrials))
        return numer / denom
    }
    
    public func expected() -> Double {
        return Double(numberOfTrials) * (Double(successesInPopulation) / Double(population))
    }
    
    public func variance() -> Double {
        let M = Double(successesInPopulation)
        let n = Double(numberOfTrials)
        let N = Double(population)
        return ((N-n)/(N-1)) * n * (1 - (M/N))
    }
}
