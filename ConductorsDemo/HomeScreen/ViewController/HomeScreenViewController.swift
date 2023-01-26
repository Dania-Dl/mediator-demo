//
//  HomeScreenViewController.swift
//  ConductorsDemo
//
//  Created by Peter Mosaad on 12.11.19.
//  Copyright © 2019 Peter Mosaad. All rights reserved.
//

import UIKit

final class HomeScreenViewController: UIViewController {

  @IBOutlet private weak var bannerView: BannerView!

  var presenter: HomeScreenPresenter!

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.onViewDidLoad(with: bannerView)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupAppearance()
    presenter.onViewWillAppear()
  }

  private func setupAppearance() {
    navigationController?.navigationBar.barStyle = .default
  }
}

extension HomeScreenViewController: HomeView {
  func setup(with navigationBar: NavigationBarView) {

    navigationItem.titleView = navigationBar
    navigationBar.isUserInteractionEnabled = true
    navigationBar.layer.masksToBounds = false
  }
}
