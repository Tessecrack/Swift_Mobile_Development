import Foundation

public protocol Player {
    var name: String { get }
    var type: String { get }
}

public enum PlayerAction {
    case win
    case step(square: Int)
}
