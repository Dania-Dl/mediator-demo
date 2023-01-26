//
//  NavigationBarComponent.swift
//  ConductorsDemo
//
//  Created by Peter Mosaad on 12.11.19.
//  Copyright © 2019 Peter Mosaad. All rights reserved.
//

import Foundation

protocol NavigationBarComponentDelegate: AnyObject {
  func buttonClicked()
}

protocol NavigationBarComponentDataProvider {
  var count: Int { get }
  var isRunning: Bool { get }
}

protocol NavigationBarComponentObserver {
  func update()
}

final class NavigationBarComponent {

  let view = NavigationBarView.initFromNib()!
  private let dataProvider: NavigationBarComponentDataProvider
  weak var delegate: NavigationBarComponentDelegate?

  init(dataProvider: NavigationBarComponentDataProvider) {
    self.dataProvider = dataProvider
    view.onButtonClicked = { [unowned self] in
      self.delegate?.buttonClicked()
    }
  }
}

private extension NavigationBarComponent {
  func onActionButtonClicked() {
    delegate?.buttonClicked()
  }

  func generateViewModel() -> NavigationBarViewViewModel {
    let title = dataProvider.isRunning ? "Stop" : "Start"
    let counter = dataProvider.isRunning ? "\(dataProvider.count)" : "Not Running"
    return NavigationBarViewViewModel(counter: counter, buttonTitle: title)
  }
}

extension NavigationBarComponent: NavigationBarComponentObserver {
  func update() {
    view.update(with: generateViewModel())
  }
}
