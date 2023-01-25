//
//  HomeScreenRouter.swift
//  ConductorsDemo
//
//  Created by Peter Mosaad on 12.11.19.
//  Copyright © 2019 Peter Mosaad. All rights reserved.
//

import Foundation
import UIKit

protocol HomeScreenRouting: AnyObject {
  func start(with window: UIWindow)
}

class HomeScreenRouter: HomeScreenRouting {

  private var homeScreenNavigationController: UINavigationController?

  private lazy var homeScreenViewController: HomeScreenViewController = {
    let view = HomeScreenViewController(nibName: "HomeScreenViewController", bundle: nil)
    let diContainer = DIContainer()
    let presenter: HomeScreenPresenter = HomeScreenPresenter(
        view: view,
        diContainer: diContainer
      )
    presenter.router = self
    view.presenter = presenter
    return view
  }()

  func start(with window: UIWindow) {
    homeScreenNavigationController = UINavigationController(rootViewController: homeScreenViewController)
    window.rootViewController = homeScreenNavigationController
  }
}
