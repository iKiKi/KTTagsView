//
//  TagsHeaderReusableView.swift
//  KTTagsView
//
//  Copyright © 2018 KTTagsView. All rights reserved.
//

import UIKit
import Reusable
import KTTagsView

final class TagsHeaderReusableView: CollectionReusableView, NibReusable {
  
  // MARK: Outlets
  
  @IBOutlet weak var ibLabel: UILabel!
  
  // MARK: Properties
  
  private static var attributes: [NSAttributedStringKey: Any] {
    #if os(iOS)
      let font: UIFont = .systemFont(ofSize: 17, weight: .ultraLight)
    #else
      let font: UIFont = .systemFont(ofSize: 48, weight: .regular)
    #endif
    let color: UIColor = .black
    return [.font: font, .foregroundColor: color]
  }
  
  // MARK: - Overrides
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = .white
  }
  
  // MARK: - Internal methods
  
  func update(with viewModel: TagsViewModel) {
    self.ibLabel.attributedText = NSAttributedString(string: viewModel.title, attributes: TagsHeaderReusableView.attributes)
  }
  
  // MARK: - Actions
}

// MARK: - Private methods
private extension ViewController {
  
}

// MARK: - CollectionReusableViewSizable
extension TagsHeaderReusableView: CollectionReusableViewSizable {
  
  static func preferredSize(with contentSize: CGSize, viewModel: TagsViewModel, in section: Int) -> CGSize {
    #if os(iOS)
      let height: CGFloat = 44
    #else
      let height: CGFloat = 120
    #endif
    return CGSize(width: contentSize.width, height: height)
  }
}
