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
    
    //1 is noughts, 2 is cross
    
    @IBOutlet var winLabel: UILabel!
    
    var player = 1
    
    var activeGame = true
    
    var winningCombitnation = [[2, 4, 6], [0,4,8], [0, 1, 2], [0,3,6], [1, 4, 7], [2, 5 , 8], [3, 4, 5], [6, 7, 8]]
    
    var gameState = [Int](repeatElement(0, count: 9))  // 0 - empty, 1 -noughts, 2 - crosses
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playAgainButton.isHidden = true
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
                activeGame = false
                playAgainButton.isHidden = false
                winLabel.isHidden = false
                switch gameState[combination[0]] {
                case 1:
                    self.winLabel.text = "Player O Won!"
                case 2:
                    self.winLabel.text = "Player X Won!"
                default:
                    return
                }
            } else {
                    var tie = true
                    for state in gameState {
                        if state == 0 {
                            tie = false
                        }
                    }
                    if tie == true {
                        self.activeGame = false
                        self.winLabel.isHidden = false
                        self.winLabel.text = "This game is tied!"
                        self.playAgainButton.isHidden = false
                    }
                }
                //print(gameState[combination[0]])
            }
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
        winLabel.isHidden = true
        playAgainButton.isHidden = true
        

    }
    }
    


