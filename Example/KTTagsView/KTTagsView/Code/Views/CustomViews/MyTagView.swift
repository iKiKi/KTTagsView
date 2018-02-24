//
//  KeywordView.swift
//  KTTagsView
//
//  Copyright © 2018 KTTagsView. All rights reserved.
//

import UIKit
import Reusable
import KTTagsView

final class MyTagView: UIView, NibLoadable {

  // MARK: Outlets
  
  @IBOutlet weak var ibLabel: UILabel!
  
  // MARK: Properties
  
  private static var tagAttributes: [NSAttributedStringKey: Any] {
    #if os(iOS)
      let font: UIFont = .systemFont(ofSize: 17, weight: .light)
    #else
      let font: UIFont = .systemFont(ofSize: 48, weight: .medium)
    #endif
    let color: UIColor = .white
    return [.font: font, .foregroundColor: color]
  }

  // MARK: - Initializers

  // MARK: - Overrides

  override func awakeFromNib() {
    super.awakeFromNib()

    self.configureView()
  }

  // MARK: - Internal methods
  
  func update(with tag: String) {
    self.ibLabel.attributedText = NSAttributedString(string: tag, attributes: MyTagView.tagAttributes)
  }

  // MARK: - Actions
}

// MARK: - Private methods
private extension MyTagView {

  func configureView() {
    self.backgroundColor = .black
    
    #if os(iOS)
      self.layer.cornerRadius = 4
    #else
      self.layer.cornerRadius = 16
    #endif
    self.layer.borderWidth = 0
    self.layer.borderColor = UIColor.black.cgColor
  }
}

// MARK: - TagSizable
extension MyTagView: TagSizable {
  
  static func preferredSize(with contentSize: CGSize, tag: String, at index: Int) -> CGSize {
    #if os(iOS)
      let margins: CGFloat = 2 * 4
    #else
      let margins: CGFloat = 2 * 16
    #endif
    let adjustedSize = CGSize(width: contentSize.width - margins, height: contentSize.height - margins)
    let width = UILabel.width(fitting: adjustedSize, string: tag, attributes: MyTagView.tagAttributes)
    let height = UILabel.height(fitting: adjustedSize, string: tag, attributes: MyTagView.tagAttributes)
    // Uncomment to assert the width too large fatal error
//    return CGSize(width: width, height: height)
    let constrainedWidth: CGFloat = min(contentSize.width, width + margins)
    return CGSize(width: constrainedWidth, height: height + margins)
  }
}

private extension UILabel {
  
  class func width(fitting containerSize: CGSize, string: String, attributes: [NSAttributedStringKey: Any]) -> CGFloat {
    let boundingSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: containerSize.height)
    let attributedString = NSAttributedString(string: string, attributes: attributes)
    let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
    let boundingRect = attributedString.boundingRect(with: boundingSize, options: options, context: nil)
    return ceil(boundingRect.width)
  }
  
  class func height(fitting containerSize: CGSize, string: String, attributes: [NSAttributedStringKey: Any]) -> CGFloat {
    let boundingSize = CGSize(width: containerSize.width, height: CGFloat.greatestFiniteMagnitude)
    let attributedString = NSAttributedString(string: string, attributes: attributes)
    let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
    let boundingRect = attributedString.boundingRect(with: boundingSize, options: options, context: nil)
    return ceil(boundingRect.height)
  }
}
