//
//  CollectionReusableView.swift
//  KTTagsView
//
//  Copyright © 2018 KTTagsView. All rights reserved.
//

import UIKit

protocol CollectionReusableViewSizable: class {
  
  static func preferredSize(with contentSize: CGSize, viewModel: TagsViewModel, in section: Int) -> CGSize
}

class CollectionReusableView: UICollectionReusableView {
  
  // MARK: Outlets
  
  // MARK: Properties
  
  // MARK: - Overrides
  
  // MARK: - Internal methods
  
  // MARK: - Actions
}

// MARK: - Private methods
private extension CollectionReusableView {
  
}
