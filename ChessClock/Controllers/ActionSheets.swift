//
//  ActionSheetsViewController.swift
//  ChessClock
//
//  Created by Кирилл Софрин on 01.03.2023.
//

import UIKit

extension MainMenuViewController {
    
    func resetActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let resetAction = UIAlertAction(title: "Reset", style: .destructive) { _ in
            self.resetAllToNewGame()
            
            self.topTimerValue = self.generalGameMode.0
            self.bottomTimerValue = self.generalGameMode.0
            
            self.topTimeInMilliseconds = self.generalGameMode.1
            self.bottomTimeInMilliseconds = self.generalGameMode.1
        }
        alertController.addAction(resetAction)
         
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func settingActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let bulletAction = UIAlertAction(title: "Bullet", style: .default) { _ in
            self.resetAllToNewGame()
            
            self.generalGameMode = (TimerInitial.bullet.text, ChessGame.bullet.mode)
            
            self.topTimerValue = self.generalGameMode.0
            self.bottomTimerValue = self.generalGameMode.0
            
            self.topTimeInMilliseconds = self.generalGameMode.1
            self.bottomTimeInMilliseconds = self.generalGameMode.1
        }
        alertController.addAction(bulletAction)
        
        let blitzAction = UIAlertAction(title: "Blitz", style: .default) { _ in
            self.resetAllToNewGame()
            
            self.generalGameMode = (TimerInitial.blitz.text, ChessGame.blitz.mode)
            
            self.topTimerValue = self.generalGameMode.0
            self.bottomTimerValue = self.generalGameMode.0
            
            self.topTimeInMilliseconds = self.generalGameMode.1
            self.bottomTimeInMilliseconds = self.generalGameMode.1
        }
        alertController.addAction(blitzAction)
        
        let rapidAction = UIAlertAction(title: "Rapid", style: .default) { _ in
            self.resetAllToNewGame()
            
            self.generalGameMode = (TimerInitial.rapid.text, ChessGame.rapid.mode)
            
            self.topTimerValue = self.generalGameMode.0
            self.bottomTimerValue = self.generalGameMode.0
            
            self.topTimeInMilliseconds = self.generalGameMode.1
            self.bottomTimeInMilliseconds = self.generalGameMode.1
        }
        alertController.addAction(rapidAction)
        
        let classicAction = UIAlertAction(title: "Classic", style: .default) { _ in
            self.resetAllToNewGame()
            
            self.generalGameMode = (TimerInitial.classic.text, ChessGame.classic.mode)
            
            self.topTimerValue = self.generalGameMode.0
            self.bottomTimerValue = self.generalGameMode.0
            
            self.topTimeInMilliseconds = self.generalGameMode.1
            self.bottomTimeInMilliseconds = self.generalGameMode.1
        }
        alertController.addAction(classicAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) 
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
