//
//  BannerComponent.swift
//  ConductorsDemo
//
//  Created by Peter Mosaad on 12.11.19.
//  Copyright © 2019 Peter Mosaad. All rights reserved.
//

import Foundation
import UIKit

protocol BannerComponentDelegate: AnyObject {
  func bannerButtonClicked()
}

protocol BannerDataProvider {
  var count: Int { get }
  var isRunning: Bool { get }
}

final class BannerComponent {

  private let view: BannerView
  private let dataProvider: BannerDataProvider
  weak var delegate: BannerComponentDelegate?

  init(
    view: BannerView,
    dataProvider: BannerDataProvider
  ) {

    self.dataProvider = dataProvider
    self.view = view

    self.view.onButtonClicked = { [unowned self] in
      self.onActionButtonClicked()
    }
  }

  public func updateView() {
    view.update(with: generateViewModel())
  }
}

private extension BannerComponent {
  func onActionButtonClicked() {
    delegate?.bannerButtonClicked()
  }

  func generateViewModel() -> BannerViewViewModel {
    let isRunning = dataProvider.isRunning
    let color: UIColor = isRunning ? dataProvider.count % 2 == 0 ? .red : .blue : .clear
    let title = isRunning ? "Stop" : "Start"
    return BannerViewViewModel(
      color: color,
      title: title
    )
  }
}
