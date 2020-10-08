import Foundation

public protocol RandomNumberGenerator {
    func random() -> Int
}

public class DigitsGenerator: RandomNumberGenerator {
    let minimum = 0
    let maximum = 8
    public func random() -> Int {
        return Int.random(in: minimum..<maximum)
    }
}
