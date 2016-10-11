//
//  Gaussian.swift
//  Probably
//
//  Created by Harlan Haskins on 10/8/16.
//
//

import Foundation

typealias Normal = Gaussian

/// A Gaussian (Normal) distribution, centered around a mean, with a given
/// variance.
struct Gaussian: RandomVariable {
    private let _mean: Double
    private let _variance: Double
    public let min = 0.0
    public let max = Double.max - 1
    private let riemannInterval: Double
    
    
    /// The standard gaussian distribution with a mean of 0 and variance of 1.
    public static let normal = Gaussian(mean: 0.0, variance: 1.0)
    
    init(mean: Double, variance: Double, riemannInterval: Double = 0.01) {
        self._mean = mean
        self._variance = variance
        self.riemannInterval = riemannInterval
    }
    
    func expected() -> Double {
        return _mean
    }
    
    func variance() -> Double {
        return _variance
    }
    
    func probability(of x: Double) -> Double {
        let denom = sqrt(2 * _variance * M_PI)
        let rhs = pow(M_E, -(pow(x - _mean, 2) / (2 * _variance)))
        return (1 / denom) * rhs
    }
    
    func distribution(lessThan x: Double) -> Double {
        return (1.0 + erf((x - _mean) / (standardDeviation() * M_SQRT2))) / 2.0
    }
}
