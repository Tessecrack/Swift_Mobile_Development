import Foundation

public protocol TicTacToeDelegate: MultiplayerTurnbasedGameDelegate {}

public class TicTacToe: MultiplayerGame, TurnbasedGame {
    public let name = "TicTacToe"
    var field = [String]()
    
    public var delegate: TicTacToeDelegate?
    
    public init(fieldSize size: Int) {
        for _ in 0...size-1 {
            field.append("-");
        }
    }
    // MARK: - Step on cell
    public let randomGen = DigitsGenerator()
    // MARK: - MultiplayerGame
    public var players: [Player] = []
    
    public func join(player: Player) {
        players.append(player)
        delegate?.player(player, didJoinTheGame: self)
    }
    
    // MARK: - TurnbasedGame
    private var numberOfTurns = 0
    
    public var turns: Int {
        get { return numberOfTurns }
    }
    
    public var hasEnded: Bool {
        get {
            if players.count == 0 {
                return true;
            }
            else {
                var count = 0
                for cell in field {
                    if cell == "-" {
                        count += 1;
                    }
                }
                return count == 0 || someOneWin()
            }
        }
    }
    public func start() {}
    public func end() {}
    
    public func makeTurn() {
        printField()
        numberOfTurns += 1
        delegate?.gameDidStartTurn(self)
        for var p in players {
            playerMakeTurn(&p)
            if self.hasEnded {
                break;
            }
        }
        delegate?.gameDidEndTurn(self)
    }
    public func printField() {
        for i in 0...field.count-1 {
            if (i % 3 == 0 && i != 0){
                print("\n")
            }
            print(field[i], terminator: " ")
        }
        print("\n")
    }
    // MARK: - Player logic
    public func playerMakeTurn(_ player: inout Player) {
        delegate?.playerDidStartTurn(player)
        var number_cell = 0;
        while (true){
            number_cell = randomGen.random();
            if (field[number_cell] == "-") {
                field[number_cell] = player.type
                break;
            }
        }
        delegate?.player(player, didTakeAction: PlayerAction.step(square: (number_cell + 1)))
        if (checkWin(playerType: player.type, playerName: player.name)){
            delegate?.player(player, didTakeAction: PlayerAction.win)
        }
        delegate?.playerDidEndTurn(player)
    }
    
    public func someOneWin() -> Bool {
        for player in players {
            if (checkWin(playerType: player.type, playerName: player.name)){
                return true;
            }
        }
        return false;
    }
    public func checkWin(playerType: String, playerName: String) -> Bool {
        //rows
        let rows = 3
        let cols = 3
        for i in 0...rows-1 {
            var cells = [String]()
            for j in 0...cols-1 {
                let cell = field[i * rows + j]
                cells.append(cell)
            }
            if (isWin(cells: cells, playerType: playerType, playerName: playerName)) {
                return true;
            }
            cells.removeAll()
        }
        //cols
        for i in 0...rows-1 {
            var cells = [String]()
            for j in 0...cols-1 {
                cells.append(field[j * cols + i])
            }
            if (isWin(cells: cells, playerType: playerType, playerName: playerName)) {
                return true;
            }
            cells.removeAll()
        }
        var cells = [String]()
        for i in 0...rows-1 {
            for j in 0...cols-1 {
                if (i == j){
                    cells.append(field[j * cols + i])
                }
            }
        }
        if (isWin(cells: cells, playerType: playerType, playerName: playerName)) {
            return true;
        }
        cells.removeAll()
        return false;
    }
    
    public func isWin(cells : [String], playerType: String, playerName: String) -> Bool {
        for cell in cells {
            if (cell != playerType) {
                return false;
            }
        }
        return true;
    }
}
