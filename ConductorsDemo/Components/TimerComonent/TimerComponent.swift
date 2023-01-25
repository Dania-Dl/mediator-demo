//
//  TimerComponent.swift
//  ConductorsDemo
//
//  Created by Peter Mosaad on 12.11.19.
//  Copyright © 2019 Peter Mosaad. All rights reserved.
//

import Foundation

protocol TimerDataProvider {
  var isRunning: Bool { get }
}

protocol TimerComponentDelegate: AnyObject {
  func didTick()
  func didStop()
}

final class TimerComponent {

  weak var delegate: TimerComponentDelegate?
  private let dataProvider: TimerDataProvider

  private var timer: Timer?

  init(dataProvider: TimerDataProvider) {
    self.dataProvider = dataProvider
  }

  private func initializeTimer() -> Timer {
    return Timer.scheduledTimer(
      withTimeInterval: 1,
      repeats: true,
      block: { [weak self] _ in
        self?.delegate?.didTick()
    })
  }

  public func resetTimerState() {
    if timer == nil {
      timer = initializeTimer()
    } else {
      timer?.invalidate()
      timer = nil
      delegate?.didStop()
    }
  }
}
