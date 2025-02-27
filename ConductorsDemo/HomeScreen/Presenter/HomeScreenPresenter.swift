//
//  HomeScreenPresenter.swift
//  ConductorsDemo
//
//  Created by Peter Mosaad on 12.11.19.
//  Copyright © 2019 Peter Mosaad. All rights reserved.
//

import Foundation
import UIKit

typealias HomeScreenView = HomeView & UIViewController

protocol HomeView: AnyObject {
  func setup(with navigationBar: NavigationBarView)
}

protocol HomeScreenDelegate: AnyObject {
  func onViewWillAppear()
}

protocol HomeScreenDataProvider {
  var isRunning: Bool { get set }
  var counter: Int { get set }
}

final class HomeScreenPresenter {

  private var dataProvider: HomeScreenDataProvider
  private unowned var view: HomeScreenView
  weak var router: HomeScreenRouting?
  private let componentsFactory: HomeScreenComponentsFactory
  private var timerComponent: TimerComponent?
  private var navigationBarComponent: NavigationBarComponent?
  private var bannerComponent: BannerComponent?

  private var mediator: HomeScreenMediator?
  private weak var delegate: HomeScreenDelegate?

  init(view: HomeScreenView, diContainer: HomeScreenDIContainer, componentsFactory: HomeScreenComponentsFactory) {

    self.view = view
    self.componentsFactory = componentsFactory
    self.dataProvider = diContainer.homeScreenDataProvider
  }

  func onViewDidLoad(with bannerView: BannerView) {
    createComponents(bannerView: bannerView)
  }

  func createComponents(bannerView: BannerView) {
    timerComponent = componentsFactory.timerComponent()
    timerComponent?.delegate = self
    navigationBarComponent = componentsFactory.navigationBarComponent()
    bannerComponent = componentsFactory.bannerComponent(view: bannerView)
    if let navigationBarView = navigationBarComponent?.view {
      view.setup(with: navigationBarView)
    }
    mediator = HomeScreenMediator(
      timerComponent: timerComponent,
      navigationBarComponent: navigationBarComponent,
      bannerComponent: bannerComponent
    )
  }

  func onViewWillAppear() {
    mediator?.onHomeViewWillAppear()
  }
}

extension HomeScreenPresenter: TimerComponentDelegate {
  func didTick() {
    increaseCounter()
    mediator?.onTimerTick()
  }
  
  func didStop() {
    stopCounting()
    mediator?.onTimerStop()
  }
}

extension HomeScreenPresenter: NavigationBarComponentDelegate {
  func buttonClicked() {
    resetCounter()
    mediator?.onNaviagationBarButtonClicked()
  }
}

extension HomeScreenPresenter: BannerComponentDelegate {
  func bannerButtonClicked() {
    resetCounter()
    mediator?.onBannerButtonClicked()
  }
}

private extension HomeScreenPresenter {
  func stopCounting() {
    dataProvider.isRunning = false
  }

  func increaseCounter() {
    dataProvider.counter += 1
  }

  func resetCounter() {
    dataProvider.isRunning = !dataProvider.isRunning
    dataProvider.counter = 0
  }
}
