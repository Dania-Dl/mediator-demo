//
//  HomeScreenConductor.swift
//  ConductorsDemo
//
//  Created by Peter Mosaad on 12.11.19.
//  Copyright © 2019 Peter Mosaad. All rights reserved.
//

import Foundation

class HomeScreenConductor {

  private var timerComponent: TimerComponentObserver?
  private var navigationBarComponent: NavigationBarComponentObserver?
  private var bannerComponent: BannerComponentObserver?

  init(
    timerComponent: TimerComponentObserver? = nil,
    navigationBarComponent: NavigationBarComponentObserver? = nil,
    bannerComponent: BannerComponentObserver? = nil
  ) {
    self.timerComponent = timerComponent
    self.navigationBarComponent = navigationBarComponent
    self.bannerComponent = bannerComponent
  }

  func onTimerTick() {
    navigationBarComponent?.update()
    bannerComponent?.updateView()
  }
  
  func onTimerStop() {
    navigationBarComponent?.update()
    bannerComponent?.updateView()
  }

  func onNaviagationBarButtonClicked() {
    timerComponent?.resetTimerState()
    bannerComponent?.updateView()
  }

  func onBannerButtonClicked() {
    timerComponent?.resetTimerState()
    navigationBarComponent?.update()
  }

  func onViewWillAppear() {
    navigationBarComponent?.update()
    bannerComponent?.updateView()
  }
}
