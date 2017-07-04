//
//  ViewController.swift
//  TicTacToe
//
//  Created by Tanja Keune on 5/29/17.
//  Copyright © 2017 Tanja Keune. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var playAgainButton: UIButton!
    
    @IBOutlet var button: UIButton!
    
    @IBOutlet var labelPlayersTurn: UILabel!
    
    //1 is noughts, 2 is cross
    
    var player = Int()
    
    var showAd = false
    
    var playerOPoints = Int()
    
    var playerXPoints = Int()
    
    var resetCredits = false
    
    @IBOutlet var logoView: UIImageView!
    
    var activeGame = true
    
    var winningCombitnation = [[2, 4, 6], [0,4,8], [0, 1, 2], [0,3,6], [1, 4, 7], [2, 5 , 8], [3, 4, 5], [6, 7, 8]]
    
    var gameState = [Int](repeatElement(0, count: 9))  // 0 - empty, 1 -noughts, 2 - crosses
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playAgainButton.isHidden = true
        
        //hides the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //sets background color on view controller
        self.view.backgroundColor = UIColor(red: 245.0/255.0, green: 233.0/255.0, blue: 200.0/255.0, alpha: 1.0)

        // After reopening the view present the played moves
        if player == 2 {
            labelPlayersTurn.text = "Crosses turn."
        } else {
            labelPlayersTurn.text = "Noughts turn."
        }
        
        for i in 1...9 {
            
            //let tmpButton = self.view.viewWithTag(i+1) as? UIButton
            
            button = self.view.viewWithTag(i) as! UIButton!
            if gameState[i-1] == 1 {
                
                button.setImage(UIImage(named: "nought.png"), for: [])
            } else if gameState[i-1] == 2 {
                button.setImage(UIImage(named: "cross.png"), for: [])
            }
        }
        
        logoView.image = UIImage(named: "smallerBidLogo.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ButtonPressed(_ sender: AnyObject) {
        
            let activePosition = sender.tag - 1
        
            if gameState[activePosition] == 0 && activeGame {
        
                if player == 1 {
            
                    sender.setImage(UIImage(named: "nought.png"), for: [])
            
                    player = 2
                
                    gameState[activePosition] = 1
            
                } else {
            
                    sender.setImage(UIImage(named: "cross.png"), for: [])
            
                    player = 1
            
                    gameState[activePosition] = 2
                }
            }
        
        for combination in winningCombitnation {
            
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
            
                // we have a winner
                showAd = true
                activeGame = false
                playAgainButton.isHidden = false
                switch gameState[combination[0]] {
                case 1:
                    self.alertMessageOk(title: "Player O Won!", message: "Play again?")
                    self.labelPlayersTurn.text = "Player O Won"
                //call alert here and ask if they want to play again. resset points.
                case 2:
                    self.labelPlayersTurn.text = "Player X Won"
                    self.alertMessageOk(title: "Player X Won", message: "Play Again?")
                default:
                    return
                }
                
                //clean the board and
                resetCredits = true
                gameState = [Int](repeatElement(0, count: 9))

            } else {
                    var tie = true
                    for state in gameState {
                        if state == 0 {
                            tie = false
                        }
                    }
                    if tie == true {
                        self.showAd = true
                        self.activeGame = false
                        self.alertMessageOk(title: "This game is tied", message: "Try again")
                        //self.winLabel.text = "This game is tied!"
                        self.playAgainButton.isHidden = false
                    }
                }

            }
        
        performSegue(withIdentifier: "goBid", sender: nil)

        }
  
        
    @IBAction func playAgain(_ sender: AnyObject) {
        
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        activeGame = true
        
        player = 1
        
        for i in 1 ..< 10 {
            
            if let button = view.viewWithTag(i) as? UIButton {
                
                button.setImage(nil, for: [])
            }
            
        }
        playAgainButton.isHidden = true
        

    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBid" {
            
            if let navVC = segue.destination as? UINavigationController {
               
                if let destination = navVC.topViewController as? BidViewController {
                    
                    destination.gameStateSaved = gameState
                    destination.playerX = playerXPoints
                    destination.playerO = playerOPoints
                    destination.resetCredits = resetCredits
                    destination.showAd = showAd
                    
                }
            }
    }
   
    
    }
    
    
    
}

