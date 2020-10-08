import Foundation

public protocol Game {
    var name: String { get }
    func play()
}

public protocol GameDelegate {
    func gameDidStart(_ game: Game)
    func gameDidEnd(_ game: Game)
}

extension GameDelegate {
    public func gameDidStart(_ game: Game) {
        print("Started a new game of \(game.name)")
    }
    
    public func gameDidEnd(_ game: Game) { }
}
