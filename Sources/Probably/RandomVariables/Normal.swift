//
//  Gaussian.swift
//  Probably
//
//  Created by Harlan Haskins on 10/8/16.
//
//

import Foundation

public typealias Gaussian = Normal

/// A Normal (Gaussian) distribution, centered around a mean, with a given
/// variance.
public struct Normal: RandomVariable {
    private let _mean: Double
    private let _variance: Double
    public let min = 0.0
    public let max = Double.max - 1
    private let riemannInterval: Double
    
    
    /// The standard normal distribution with a mean of 0 and variance of 1.
    public static let standard = Normal(mean: 0.0, variance: 1.0)
    
    public init(mean: Double, variance: Double, riemannInterval: Double = 0.01) {
        self._mean = mean
        self._variance = variance
        self.riemannInterval = riemannInterval
    }
    
    public func expected() -> Double {
        return _mean
    }
    
    public func variance() -> Double {
        return _variance
    }
    
    /// Standardizes a value by adjusting it so it fits in the Standard Normal
    /// Distribution.
    ///
    /// - parameter x: The number to check, in the current distribution
    /// - returns: The value in the Standard Normal distribution with the same
    ///            cdf and pdf.
    public func standardize(x: Double) -> Double {
        return (x - _mean) / standardDeviation()
    }
    
    public func probability(of x: Double) -> Double {
        let denom = sqrt(2 * _variance * M_PI)
        let rhs = exp(-(pow(x - _mean, 2) / (2 * _variance)))
        return (1 / denom) * rhs
    }
    
    public func distribution(lessThan x: Double) -> Double {
        return (1.0 + erf((x - _mean) / (standardDeviation() * M_SQRT2))) / 2.0
    }
}
