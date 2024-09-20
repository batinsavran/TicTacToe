import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Nought
        case Cross
    }
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    let NOUGHT = "O"
    let CROSS = "X"
    
    var board = [UIButton]()
    var noughtsScore = 0
    var crossesScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard() {
        board = [a1, a2, a3, b1, b2, b3, c1, c2, c3]
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS) {
            crossesScore += 1
            resultAlert(title: "Crosses Win!")
        } else if checkForVictory(NOUGHT) {
            noughtsScore += 1
            resultAlert(title: "Noughts Win!")
        } else if fullBoard() {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ symbol: String) -> Bool {
        // Horizontal Victory
        if checkLine(a1, a2, a3, symbol) || checkLine(b1, b2, b3, symbol) || checkLine(c1, c2, c3, symbol) {
            return true
        }
        // Vertical Victory
        if checkLine(a1, b1, c1, symbol) || checkLine(a2, b2, c2, symbol) || checkLine(a3, b3, c3, symbol) {
            return true
        }
        // Diagonal Victory
        if checkLine(a1, b2, c3, symbol) || checkLine(a3, b2, c1, symbol) {
            return true
        }
        return false
    }
    
    func checkLine(_ button1: UIButton, _ button2: UIButton, _ button3: UIButton, _ symbol: String) -> Bool {
        return thisSymbol(button1, symbol) && thisSymbol(button2, symbol) && thisSymbol(button3, symbol)
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        let message = "\nNoughts: \(noughtsScore) \nCrosses: \(crossesScore)"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            self.resetBoard()
        }))
        present(ac, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        firstTurn = (firstTurn == .Nought) ? .Cross : .Nought
        turnLabel.text = (firstTurn == .Cross) ? CROSS : NOUGHT
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        return !board.contains { $0.title(for: .normal) == nil }
    }
    
    func addToBoard(_ sender: UIButton) {
        guard sender.title(for: .normal) == nil else { return }
        
        if currentTurn == .Nought {
            sender.setTitle(NOUGHT, for: .normal)
            currentTurn = .Cross
            turnLabel.text = CROSS
        } else {
            sender.setTitle(CROSS, for: .normal)
            currentTurn = .Nought
            turnLabel.text = NOUGHT
        }
        sender.isEnabled = false
    }
}

