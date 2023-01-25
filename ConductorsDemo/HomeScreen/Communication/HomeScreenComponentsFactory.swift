//
//  HomeScreenComponentsFactory.swift
//  ConductorsDemo
//
//  Created by Peter Mosaad on 12.11.19.
//  Copyright © 2019 Peter Mosaad. All rights reserved.
//

import Foundation

protocol HomeScreenDIContainer {
  var homeScreenDataProvider: HomeScreenDataProvider { get }
  var timerDataProvider: TimerDataProvider { get }
  var navigationDataProvider: NavigationBarComponentDataProvider { get }
  var bannerDataProvider: BannerDataProvider { get }
}

class HomeScreenComponentsFactory {

  private let diContainer: HomeScreenDIContainer
  private let containerViewController: HomeScreenView

  init(
    diContainer: HomeScreenDIContainer,
    containerViewController: HomeScreenView
  ) {
    self.diContainer = diContainer
    self.containerViewController = containerViewController
  }

  func timerComponent() -> TimerComponent  {
    return TimerComponent(dataProvider: diContainer.timerDataProvider)
  }

  func navigationBarComponent() -> NavigationBarComponent {
    return NavigationBarComponent(
      dataProvider: diContainer.navigationDataProvider
    )
  }

  func bannerComponent(view: BannerView) -> BannerComponent {
    return BannerComponent(
      view: view,
      dataProvider: diContainer.bannerDataProvider
    )
  }
}
