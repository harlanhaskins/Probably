//
//  Exponential.swift
//  Probably
//
//  Created by Harlan Haskins on 10/17/16.
//
//

import Foundation

/// An Exponential random variable with the provided scale value.
/// Typically used to represent time periods with exponential frequency
/// of occurrences of events.
struct Exponential: RandomVariable {
    typealias Interval = Double
    
    let min = 0.0
    let max = Double.max
    
    /// The scale of this variable (usually notated as ƛ)
    let scale: Double
    
    /// Creates an exponential random variable with the provided scale
    init(scale: Double) {
        self.scale = scale
    }
    
    /// Creates an exponential random variable with the provided mean,
    /// such that ƛ = 1 / mean
    init(mean: Double) {
        self.scale = 1 / mean
    }
    
    /// Creates an exponential random variable with the provided variance
    /// such that ƛ = 1 / sqrt(variance)
    init(variance: Double) {
        self.scale = 1 / sqrt(variance)
    }
    
    func probability(of x: Double) -> Double {
        return exp(-(scale * x)) * scale
    }
    
    func distribution(lessThan x: Double) -> Double {
        return 1.0 - exp(-(scale * x))
    }
    
    func expected() -> Double {
        return 1 / scale
    }
    
    func variance() -> Double {
        return 1 / pow(scale, 2)
    }
}
