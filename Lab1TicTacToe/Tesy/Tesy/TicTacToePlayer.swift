import Foundation

public class TicTacToePlayer : Player {
    public let name: String
    public let type: String //X or 0
    
    public init(name: String, type: String) {
        self.name = name
        self.type = type
    }
}

public class TicTacToeStepper : TicTacToeDelegate {
    public init() {}
    
    public func gameDidStartTurn(_ game: TurnbasedGame) {
    }
    
    public func gameDidEndTurn(_ game: TurnbasedGame) {
    }
    
    public func playerDidStartTurn(_ player: Player) {
        print("\(player.name) start step")
    }
}
