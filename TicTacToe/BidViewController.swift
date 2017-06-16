//
//  BidViewController.swift
//  TicTacToe
//
//  Created by Tanja Keune on 5/29/17.
//  Copyright © 2017 Tanja Keune. All rights reserved.
//

import UIKit

class BidViewController: UIViewController {

    @IBOutlet var bidTextField: UITextField!
    
    @IBOutlet var playerTurnLabel: UILabel!
    
    @IBOutlet var playerOLabel: UILabel!
    
    @IBOutlet var playerOPoints: UILabel!
    
    @IBOutlet var playerXLabel: UILabel!
    
    @IBOutlet var playerXPoints: UILabel!
    
    @IBOutlet var bid: UIButton!
    
    var activePlayer = 1 // 1 - noughts, 2 - crosses
    
    var playerX = 100
    var playerO = 100
    
    var xBid = 0
    var oBid = 0
    var sum = 0
    
    var gameStateSaved = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var sendPlayer = 0
    
    var x = 0 // 0 - didn't place a bid, 1- did placed bid
    
    var o = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerTurnLabel.text = "Player O turn. Make your bid:"
        playerOPoints.text = String(playerO)
        playerXPoints.text = String(playerX)
        print(gameStateSaved)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bidButtonPressed(_ sender: AnyObject) {
      
        let bidCurrent = Int(bidTextField.text!)!
        
        
        if activePlayer == 1 {
        
            //is noughts player
            
            if bidCurrent <= playerO {
                
                oBid = bidCurrent
                
                playerO -= oBid
                
                o = 1
                
                playerTurnLabel.textColor = UIColor.red
                playerTurnLabel.text = "Player X turn. Make your bid:"
                bidTextField.text = ""
                
                activePlayer = 2
                
            } else {
                
                playerTurnLabel.text = "Not suffisant funds, you have \(playerO) pints."
            }
            
      } else {
            
            //Crosses turn
            
            if bidCurrent <= playerX {
                
                xBid = bidCurrent
                
                playerX -= xBid
                
                x = 1
                
               // playerTurnLabel.text = "Plaer Noughts turn. Make your bid:"
                
                activePlayer = 1

                // check who won
                
                if o == 1 && x == 1 {
                    
                    o = 0
                    x = 0
                    
                    if xBid > oBid {
                        
                        playerTurnLabel.text = "Player X turn!"
                        bidTextField.isHidden = true
                        playerO += xBid + oBid
                        //won call segue to the board
                        
                        sendPlayer = 2
                        print(sendPlayer)
                        performSegue(withIdentifier: "play", sender: sendPlayer)  //2
                        
                    } else if xBid == oBid {
                        
                        print("Try again")
                        playerX += xBid
                        playerO += oBid
                        playerTurnLabel.textColor = UIColor.black
                        playerTurnLabel.text = "Plaer Noughts turn. Make your bid:"
                        bidTextField.text = ""
                        
                    } else {
                        
                        playerTurnLabel.text = "Player O turn!"
                        bidTextField.isHidden = true
                        playerX += xBid + oBid
                        //won call segue to the board
                        
                        sendPlayer = 1
                        print(sendPlayer)
                        performSegue(withIdentifier: "play", sender: sendPlayer)  //1
                        
                    }
                    playerXPoints.text = String(playerX)
                    playerOPoints.text = String(playerO)
                    bidTextField.isHidden = false

            } else {
                
                playerTurnLabel.text = "Not suffisant funds, you have \(playerX) pints."
            }
            
        }
    
    
    }
    
}
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "play" {
            
            let destination = segue.destination as! ViewController
                
            destination.player = sendPlayer
            destination.gameState = gameStateSaved
            destination.playerOPoints = playerO
            destination.playerXPoints = playerX
            
        }
    }
}
