//
//  TagsCollectionViewCell.swift
//  KTTagsView
//
//  Copyright © 2018 KTTagsView. All rights reserved.
//

import UIKit
import Reusable
import KTTagsView

final class TagsCollectionViewCell: CollectionViewCell, NibReusable {

  // MARK: Outlets

  @IBOutlet weak var ibTagsView: TagsView!

  // MARK: Properties

  // MARK: - Overrides

  override func awakeFromNib() {
    super.awakeFromNib()

    self.configureView()
  }

  // MARK: - Internal methods
  
  func update(with viewModel: TagsViewModel) {
    self.ibTagsView.reloadData(with: viewModel, dataSource: viewModel)
  }

  // MARK: - Actions
}

// MARK: - Private methods
private extension TagsCollectionViewCell {

  func configureView() {
    self.contentView.backgroundColor = .clear
    self.ibTagsView.backgroundColor = .clear
  }
}

// MARK: - CollectionViewCellSizable
extension TagsCollectionViewCell: CollectionViewCellSizable {

  static func preferredSize(with contentSize: CGSize, viewModel: TagsViewModel, at indexPath: IndexPath) -> CGSize {
    return TagsView.preferredSize(with: contentSize, provider: viewModel)
  }
}
