//
//  MainMenuView.swift
//  ChessClock
//
//  Created by Кирилл Софрин on 25.02.2023.
//

import UIKit
import SnapKit

extension MainMenuViewController {
    
    func createCentralMenuView() {
        centralMenuView.backgroundColor = Color.darkGrey.color
        view.addSubview(centralMenuView)
        
        centralMenuView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.15)
        }
    }
    
    func createTopClockUnderView() {
        topClockUnderView.backgroundColor = topClockUnderViewBackgroundColor
        view.addSubview(topClockUnderView)
        
        topClockUnderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(centralMenuView.snp.top)
        }
    }
    
    func createBottomClockUnderView() {
        bottomClockUnderView.backgroundColor = bottomClockUnderViewBackgroundColor
        view.addSubview(bottomClockUnderView)
        
        bottomClockUnderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(centralMenuView.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func createTopCounterLabel() {
        topCounterLabel.text = String(topCounterValue)
        topCounterLabel.backgroundColor = .clear
        topCounterLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .regular)
        topCounterLabel.textColor = Color.darkGrey.color
        topClockUnderView.addSubview(topCounterLabel)
        
        topCounterLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        topCounterLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    func createBottomCounterLabel() {
        bottomCounterLabel.text = String(bottomCounterValue)
        bottomCounterLabel.backgroundColor = .clear
        bottomCounterLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .regular)
        bottomCounterLabel.textColor = Color.darkGrey.color
        bottomClockUnderView.addSubview(bottomCounterLabel)
        
        bottomCounterLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func createPauseButton() {
        pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        centralMenuView.addSubview(pauseButton)
        pauseButton.addTarget(self, action: #selector(pauseButtonPressed), for: .touchUpInside)
        
        pauseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(centralMenuView.snp.height).multipliedBy(0.5)
            make.width.equalTo(pauseButton.snp.height)
        }
    }
    
    func createSettingsButton() {
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
        centralMenuView.addSubview(settingsButton)
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        
        settingsButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.center.equalToSuperview().multipliedBy(1.5)
            make.height.equalTo(centralMenuView.snp.height).multipliedBy(0.4)
            make.width.equalTo(settingsButton.snp.height)
        }
    }
    
    func createResetButton() {
        resetButton.setImage(UIImage(named: "reset"), for: .normal)
        centralMenuView.addSubview(resetButton)
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
        resetButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.center.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(centralMenuView.snp.height).multipliedBy(0.4)
            make.width.equalTo(resetButton.snp.height)
        }
    }
    
    func createTopTimerLabel() {
        topTimerLabel.text = topTimerValue
        topTimerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 95, weight: .bold)
        topTimerLabel.textColor = topTimerTextColor
        topTimerLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        topClockUnderView.addSubview(topTimerLabel)
        
        topTimerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func createBottomTimerLabel() {
        bottomTimerLabel.text = bottomTimerValue
        bottomTimerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 95, weight: .bold)
        bottomTimerLabel.textColor = bottomTimerTextColor
        bottomClockUnderView.addSubview(bottomTimerLabel)
        
        bottomTimerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func createTopView() {
        topClockUnderView.addSubview(topView)
        topView.backgroundColor = UIColor.clear
        topRecognizer.addTarget(self, action: #selector(topViewTapped))
        topView.addGestureRecognizer(topRecognizer)

        topView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
    
    func createBottomView() {
        bottomClockUnderView.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.clear
        bottomRecognizer.addTarget(self, action: #selector(bottomViewTapped))
        bottomView.addGestureRecognizer(bottomRecognizer)
        
        bottomView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
}
