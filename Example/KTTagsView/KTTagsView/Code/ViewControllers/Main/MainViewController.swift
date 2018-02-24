//
//  MainViewController.swift
//  KTTagsView
//
//  Copyright © 2018 KTTagsView. All rights reserved.
//

import UIKit
import Reusable

final class MainViewController: ViewController {

  // MARK: Outlets

  @IBOutlet weak var ibCollectionView: UICollectionView!

  // MARK: Properties

  private let viewModels: [TagsViewModel] = [
    TagsViewModel(withTitle: L10n.case1, mode: .default, horizontalAlignment: .left,   verticalAlignment: .top,    minimumIntertagSpacing: 8),
    TagsViewModel(withTitle: L10n.case2, mode: .default, horizontalAlignment: .center, verticalAlignment: .top,    minimumIntertagSpacing: 8),
    TagsViewModel(withTitle: L10n.case3, mode: .default, horizontalAlignment: .right,  verticalAlignment: .top,    minimumIntertagSpacing: 8),
    TagsViewModel(withTitle: L10n.case4, mode: .single,  horizontalAlignment: .left,   verticalAlignment: .top,    minimumIntertagSpacing: 8),
    TagsViewModel(withTitle: L10n.case5, mode: .heights, horizontalAlignment: .left,   verticalAlignment: .top,    minimumIntertagSpacing: 8),
    TagsViewModel(withTitle: L10n.case6, mode: .heights, horizontalAlignment: .center, verticalAlignment: .top,    minimumIntertagSpacing: 8),
    TagsViewModel(withTitle: L10n.case7, mode: .heights, horizontalAlignment: .right,  verticalAlignment: .top,    minimumIntertagSpacing: 8),
    TagsViewModel(withTitle: L10n.case8, mode: .heights, horizontalAlignment: .left,   verticalAlignment: .center, minimumIntertagSpacing: 8),
    TagsViewModel(withTitle: L10n.case9, mode: .heights, horizontalAlignment: .left,   verticalAlignment: .bottom, minimumIntertagSpacing: 8)
  ]

  // MARK: - Initializers

  deinit {
    debugPrint("\(#function): \(self)")
  }

  // MARK: - Overrides

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = L10n.pod
    
    if let layout = self.ibCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.sectionHeadersPinToVisibleBounds = true
    }
    
    self.registerSupplementaryViews(self.ibCollectionView)
    self.registerCells(self.ibCollectionView)
  }

  // MARK: - Internal methods

  // MARK: - Actions
}

// MARK: - Private methods
private extension MainViewController {

  func registerSupplementaryViews(_ collectionView: UICollectionView) {
    collectionView.register(supplementaryViewType: TagsHeaderReusableView.self, ofKind: UICollectionElementKindSectionHeader)
  }
  
  func registerCells(_ collectionView: UICollectionView) {
    collectionView.register(cellType: TagsCollectionViewCell.self)
  }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.viewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TagsCollectionViewCell.self)
    let viewModel = self.viewModels[indexPath.section]
    cell.update(with: viewModel)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath, viewType: TagsHeaderReusableView.self)
    let viewModel = self.viewModels[indexPath.section]
    reusableView.update(with: viewModel)
    return reusableView
  }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let viewModel = self.viewModels[indexPath.section]
    return TagsCollectionViewCell.preferredSize(with: collectionView.bounds.size, viewModel: viewModel, at: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let viewModel = self.viewModels[section]
    return TagsHeaderReusableView.preferredSize(with: collectionView.bounds.size, viewModel: viewModel, in: section)
  }
}
