//
//  ViewController.swift
//  ChessClock
//
//  Created by Кирилл Софрин on 25.02.2023.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    lazy var centralMenuView = UIView()
    lazy var topClockUnderView = UIView()
    lazy var bottomClockUnderView = UIView()
    lazy var topCounterLabel = UILabel()
    lazy var bottomCounterLabel = UILabel()
    lazy var pauseButton = CentralMenuButtons()
    lazy var settingsButton = CentralMenuButtons()
    lazy var resetButton = CentralMenuButtons()
    lazy var topTimerLabel = UILabel()
    lazy var bottomTimerLabel = UILabel()
    
    lazy var topView = UIView()
    lazy var topRecognizer = UITapGestureRecognizer()
    lazy var bottomView = UIView()
    lazy var bottomRecognizer = UITapGestureRecognizer()
    
    var topClockUnderViewBackgroundColor = Color.lightGrey.color
    var bottomClockUnderViewBackgroundColor = Color.lightGrey.color
    
    var isItTopPlayerTurn: Bool?
    var isItBottomPlayerTurn: Bool?
    
    var topCounterValue = 0
    var bottomCounterValue = 0
    
    var topTimerTextColor = UIColor.black
    var bottomTimerTextColor = UIColor.black
    
    var isPause = false
    var isGameOver = false
    
    var topTimer: Timer?
    var bottomTimer: Timer?
    
    var generalGameMode = (TimerInitial.blitz.text, ChessGame.blitz.mode)
    
    var topTimerValue = TimerInitial.blitz.text
    var bottomTimerValue = TimerInitial.blitz.text
    
    var topTimeInMilliseconds = ChessGame.blitz.mode
    var bottomTimeInMilliseconds = ChessGame.blitz.mode
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidePauseButton()
    }
    
    override func viewWillLayoutSubviews() {
        createCentralMenuView()
        createTopClockUnderView()
        createBottomClockUnderView()
        createTopCounterLabel()
        createBottomCounterLabel()
        createPauseButton()
        createSettingsButton()
        createResetButton()
        createTopTimerLabel()
        createBottomTimerLabel()
        createTopView()
        createBottomView() 
    }
    
    
    // MARK: - Top Timer
    func startTopTimer() {
        topTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(topTimerTick), userInfo: nil, repeats: true)
    }
    
    func stopTopTimer() {
        topTimer?.invalidate()
        topTimer = nil
    }
    
    @objc func topTimerTick() {
        if topTimeInMilliseconds > 0 {
            topTimeInMilliseconds -= 1
            topTimerValue = stringFromTimeInterval(interval: TimeInterval(topTimeInMilliseconds))
            topTimerLabel.text = topTimerValue
        } else {
            stopTopTimer()
            setRedBackgroundColorToTopTimer()
            topView.isUserInteractionEnabled = false
            bottomView.isUserInteractionEnabled = false
            isGameOver = true
            hidePauseButton()
        }
    }
    
    
    // MARK: - Bottom Timer
    func startBottomTimer() {
        bottomTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(bottomTimerTick), userInfo: nil, repeats: true)
    }
    
    func stopBottomTimer() {
        bottomTimer?.invalidate()
        bottomTimer = nil
    }
    
    @objc func bottomTimerTick() {
        if bottomTimeInMilliseconds > 0 {
            bottomTimeInMilliseconds -= 1
            bottomTimerValue = stringFromTimeInterval(interval: TimeInterval(bottomTimeInMilliseconds))
            bottomTimerLabel.text = bottomTimerValue
        } else {
            stopBottomTimer()
            setRedBackgroundColorToBottomTimer()
            turnOffUserInteractionToTopAndBottomView()
            isGameOver = true
            hidePauseButton()
        }
    }
    
    
    // MARK: - Converting Milliseconds To The Correct Format
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let tenths = Int(interval / 100) % 10
        let seconds = Int(interval / 1000) % 60
        let minutes = Int(interval / 60000)
        
        if minutes == 0 && seconds < 10 {
            return String(format: "%01d:%02d.%01d", minutes, seconds, tenths)
        } else {
            return String(format: "%01d:%02d", minutes, seconds)
        }
    }
    
    
    // MARK: - Top View Tapped
    @objc func topViewTapped() {
        // start new game
        if isItTopPlayerTurn == nil {
            startBottomTimer()
            passTurnToTheBottomPlayer()
            turnOnBottomView()
            showPauseButton()
            return
        }
        
        // check for pause
        if isPause {
            if isItTopPlayerTurn! {
                return
            } else if isItBottomPlayerTurn! {
                startBottomTimer()
                isPause = false
                turnOnBottomView()
                showPauseButton()
                return
            }
        }
    
        // switch
        if isItTopPlayerTurn! {
            stopTopTimer()
            startBottomTimer()
            passTurnToTheBottomPlayer()
            turnOffTopView()
            turnOnBottomView()
            incrementTopCounter()
            return
        }
        
        // when player taps the button outside of his turn
        if isItBottomPlayerTurn! {
            return
        }
    }
    
    
    // MARK: - Bottom View Tapped
    @objc func bottomViewTapped() {
        // start new game
        if isItBottomPlayerTurn == nil {
            startTopTimer()
            passTurnToTheTopPlayer()
            turnOnTopView()
            showPauseButton()
            return
        }
        
        // check for pause
        if isPause {
            if isItBottomPlayerTurn! {
                return
            } else if isItTopPlayerTurn! {
                startTopTimer()
                isPause = false
                turnOnTopView()
                showPauseButton()
                return
            }
        }
        
        // switch
        if isItBottomPlayerTurn! {
            stopBottomTimer()
            startTopTimer()
            passTurnToTheTopPlayer()
            turnOffBottomView()
            turnOnTopView()
            incrementBottomCounter()
            return
        }
        
        // when player taps the button outside of his turn
        if isItTopPlayerTurn! {
            return
        }
    }
    
    
    // MARK: - Central Menu Buttons Pressed
    @objc func resetButtonPressed() {
        if isGameOver {
            resetActionSheet()
        } else if isItTopPlayerTurn == nil && isItBottomPlayerTurn == nil {
            resetActionSheet()
        } else {
            isPause = true
            hidePauseButton()
            setGreyViewAndBlackTimer()
            
            stopTopTimer()
            stopBottomTimer()
            
            resetActionSheet()
        }
    }
    
    @objc func pauseButtonPressed() {
        stopTopTimer()
        stopBottomTimer()
        
        isPause = true
        setGreyViewAndBlackTimer()
        
        hidePauseButton()
    }
    
    @objc func settingsButtonPressed() {
        if isGameOver {
            settingActionSheet()
        } else if isItTopPlayerTurn == nil && isItBottomPlayerTurn == nil {
            settingActionSheet()
        } else {
            isPause = true
            hidePauseButton()
            setGreyViewAndBlackTimer()
            
            stopTopTimer()
            stopBottomTimer()
            
            settingActionSheet()
        }
    }
}


// MARK: - Helpers Methods
extension MainMenuViewController {
    
    func turnOnTopView() {
        topClockUnderViewBackgroundColor = Color.blue.color
        topClockUnderView.backgroundColor = topClockUnderViewBackgroundColor
        
        topTimerTextColor = .white
        topTimerLabel.textColor = topTimerTextColor
    }
    
    func turnOnBottomView() {
        bottomClockUnderViewBackgroundColor = Color.blue.color
        bottomClockUnderView.backgroundColor = bottomClockUnderViewBackgroundColor
        
        bottomTimerTextColor = .white
        bottomTimerLabel.textColor = bottomTimerTextColor
    }
    
    func turnOffTopView() {
        topClockUnderViewBackgroundColor = Color.lightGrey.color
        topClockUnderView.backgroundColor = topClockUnderViewBackgroundColor
        
        topTimerTextColor = .black
        topTimerLabel.textColor = topTimerTextColor
    }
    
    func turnOffBottomView() {
        bottomClockUnderViewBackgroundColor = Color.lightGrey.color
        bottomClockUnderView.backgroundColor = bottomClockUnderViewBackgroundColor
        
        bottomTimerTextColor = .black
        bottomTimerLabel.textColor = bottomTimerTextColor
    }
    
    func setRedBackgroundColorToTopTimer() {
        topClockUnderViewBackgroundColor = Color.red.color
        topClockUnderView.backgroundColor = topClockUnderViewBackgroundColor
    }
    
    func setRedBackgroundColorToBottomTimer() {
        bottomClockUnderViewBackgroundColor = Color.red.color
        bottomClockUnderView.backgroundColor = bottomClockUnderViewBackgroundColor
    }
    
    func incrementTopCounter() {
        topCounterValue += 1
        topCounterLabel.text = String(topTimerValue)
    }
    
    func incrementBottomCounter() {
        bottomCounterValue += 1
        bottomCounterLabel.text = String(bottomCounterValue)
    }
    
    func resetCounters() {
        topCounterValue = 0
        topCounterLabel.text = String(topTimerValue)
        bottomCounterValue = 0
        bottomCounterLabel.text = String(bottomCounterValue)
    }
    
    func setGreyViewAndBlackTimer() {
        topClockUnderViewBackgroundColor = Color.lightGrey.color
        topClockUnderView.backgroundColor = topClockUnderViewBackgroundColor
        bottomClockUnderViewBackgroundColor = Color.lightGrey.color
        bottomClockUnderView.backgroundColor = bottomClockUnderViewBackgroundColor
        
        topTimerTextColor = .black
        topTimerLabel.textColor = topTimerTextColor
        
        bottomTimerTextColor = .black
        bottomTimerLabel.textColor = bottomTimerTextColor
    }
    
    func turnOnUserInteractionToTopAndBottomView() {
        topView.isUserInteractionEnabled = true
        bottomView.isUserInteractionEnabled = true
    }
    
    func turnOffUserInteractionToTopAndBottomView() {
        topView.isUserInteractionEnabled = false
        bottomView.isUserInteractionEnabled = false
    }
    
    func passTurnToTheTopPlayer() {
        isItBottomPlayerTurn = false
        isItTopPlayerTurn = true
    }
    
    func passTurnToTheBottomPlayer() {
        isItTopPlayerTurn = false
        isItBottomPlayerTurn = true
    }
    
    func turnOnPause() {
        isPause = true
    }
    
    func turnOffPause() {
        isPause = false
    }
    
    func hidePauseButton() {
        pauseButton.isHidden = true
        pauseButton.isEnabled = false
    }
    
    func showPauseButton() {
        pauseButton.isHidden = false
        pauseButton.isEnabled = true
    }
    
    func resetAllToNewGame() {
        isItTopPlayerTurn = nil
        isItBottomPlayerTurn = nil
        
        resetCounters()
        
        setGreyViewAndBlackTimer()
        
        turnOffPause()
        isGameOver = false
        
        turnOnUserInteractionToTopAndBottomView()
    }
}


// MARK: - Extra Touch Area
class CentralMenuButtons: UIButton {
    
    private let extraTouchArea: CGFloat = 10
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let extendedBounds = bounds.insetBy(dx: -extraTouchArea, dy: -extraTouchArea)
        return extendedBounds.contains(point) ? self : nil
    }
}

