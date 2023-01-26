//
//  HomeScreenConductor.swift
//  ConductorsDemo
//
//  Created by Peter Mosaad on 12.11.19.
//  Copyright © 2019 Peter Mosaad. All rights reserved.
//

import Foundation

class HomeScreenConductor {

  private let presenter: HomeScreenPresenter
  private var timerComponent: TimerComponent?
  private var navigationBarComponent: NavigationBarComponent?
  private var bannerComponent: BannerComponent?

  init(
    presenter: HomeScreenPresenter,
    timerComponent: TimerComponent? = nil,
    navigationBarComponent: NavigationBarComponent? = nil,
    bannerComponent: BannerComponent? = nil
  ) {
    self.presenter = presenter
    self.timerComponent = timerComponent
    self.navigationBarComponent = navigationBarComponent
    self.bannerComponent = bannerComponent
    self.timerComponent?.delegate = self
    self.navigationBarComponent?.delegate = self
    self.bannerComponent?.delegate = self
  }
}

extension HomeScreenConductor: TimerComponentDelegate {
  func didTick() {
    presenter.increaseCounter()
    navigationBarComponent?.update()
    bannerComponent?.updateView()
  }
  
  func didStop() {
    presenter.stopCounting()
    navigationBarComponent?.update()
    bannerComponent?.updateView()
  }
}

extension HomeScreenConductor: NavigationBarComponentDelegate {
  func buttonClicked() {
    presenter.resetCounter()
    timerComponent?.resetTimerState()
    bannerComponent?.updateView()
  }
}

extension HomeScreenConductor: BannerComponentDelegate {
  func bannerButtonClicked() {
    presenter.resetCounter()
    timerComponent?.resetTimerState()
    navigationBarComponent?.update()
  }
}

extension HomeScreenConductor: HomeScreenDelegate {
  func onViewWillAppear() {
    navigationBarComponent?.update()
    bannerComponent?.updateView()
  }
}
