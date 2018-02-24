//
//  CollectionViewCell.swift
//  KTTagsView
//
//  Copyright © 2018 KTTagsView. All rights reserved.
//

import UIKit

protocol CollectionViewCellSizable: class {

  static func preferredSize(with contentSize: CGSize, viewModel: TagsViewModel, at indexPath: IndexPath) -> CGSize
}

class CollectionViewCell: UICollectionViewCell {

  // MARK: Outlets

  // MARK: Properties

  // MARK: - Overrides

  // MARK: - Internal methods

  // MARK: - Actions
}

// MARK: - Private methods
private extension CollectionViewCell {

}
