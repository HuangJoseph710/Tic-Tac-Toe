
import Foundation

class SecondGameState: ObservableObject {
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var noughtsScore = 0
    @Published var crossesScore = 0
    @Published var showAlert = false
    @Published var alertMessage = "Draw"
    @Published var distance = CGFloat(-80)
    
    
    
    
    init() {
        resetBoard()
    }
    
    func restartGame(){
        resetBoard()
        noughtsScore = 0
        crossesScore = 0
    }
    
    func turnText() -> String {
        return turn == Tile.Cross ? "Turn: X" : "Turn: O"
    }
    
    func canPlace(_ row: Int,_ column: Int) -> Bool{
        return board[row][column].tile == Tile.Empty && showAlert == false && turn == Tile.Cross
    }
    
    
    func placeTile(_ row: Int,_ column: Int) {
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        if(checkForVictory()) {
            if(turn == Tile.Cross)
            {
                crossesScore += 1
            }
            else
            {
                noughtsScore += 1
            }
            let winner = turn == Tile.Cross ? "Player" : "Computer"
            alertMessage = winner + " Win!"
            showAlert = true
        }
        else {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        
        if(checkForDraw()) {
            alertMessage = "Draw"
            showAlert = true
        }
        
        if(turn == Tile.Nought && showAlert == false){
            makeMoveByRobot()
        }
    }
    
    func checkForDraw() -> Bool {
        for row in board {
            for cell in row {
                if cell.tile == Tile.Empty {
                    return false
                }
            }
        }
        
        return true
    }
    
    func checkForVictory() -> Bool
    {
        // vertical victory
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0)
        {
            return true
        }
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2)
        {
            return true
        }
        
        // horizontal victory
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2)
        {
            return true
        }
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2)
        {
            return true
        }
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2)
        {
            return true
        }
        
        // diagonal victory
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0)
        {
            return true
        }
        
        
        return false
    }
    
    func isTurnTile(_ row: Int,_ column: Int) -> Bool {
        return board[row][column].tile == turn
    }
    
    
    func resetBoard()
    {
        showAlert = false
        turn = Tile.Cross
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2
            {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
    
    func makeMoveByRobot() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // 添加延遲
            var availableCells = [(Int,Int)]()
            
            for row in 0..<self.board.count {
                for col in 0..<self.board[row].count {
                    if self.board[row][col].tile == Tile.Empty {
                        availableCells.append((row, col))
                    }
                }
            }
            
            guard let randomCell = availableCells.randomElement() else {
                return
            }
            
            let row = randomCell.0
            let col = randomCell.1
            self.placeTile(row, col)
        }
        
    }
    
    
}
