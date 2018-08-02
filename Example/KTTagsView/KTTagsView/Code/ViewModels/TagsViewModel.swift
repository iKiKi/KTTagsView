//
//  TagsViewModel.swift
//  KTTagsView
//
//  Copyright © 2018 KTTagsView. All rights reserved.
//

import Foundation
import UIKit
import KTTagsView

final class TagsViewModel: TagsProvider {
  
  enum Mode {
    case `default`
    case single
    case heights
  }
  
  // MARK: Properties
  
  let title: String
  let mode: Mode

  var tags: [String] {
    switch self.mode {
    case .single:
      return self.single
    case .heights:
      return self.heights
    default:
      return self.defaults
    }
  }
  
  private var defaults: [String] = [
    "The Basics",
    "Basic Operators",
    "Strings and Characters",
    "Collection Types",
    "Control Flow",
    "Functions",
    "Closures",
    "Enumerations",
    "Classes and Structures",
    "Properties",
    "Methods",
    "Subscripts",
    "Inheritance",
    "Initialization",
    "Deinitialization",
    "Optional Chaining",
    "Error Handling",
    "Type Casting",
    "Nested Types",
    "Extensions",
    "Protocols",
    "Generics",
    "Automatic Reference Counting",
    "Memory Safety",
    "Access Control",
    "Advanced Operators"
  ]
  
  private var single: [String] = [
    """
    Swift is a fantastic way to write software, whether it’s for phones, desktops, servers, or anything else that runs code.
    It’s a safe, fast, and interactive programming language that combines the best in modern language thinking with wisdom from the wider Apple engineering culture and the diverse contributions from its open-source community.
    The compiler is optimized for performance and the language is optimized for development, without compromising on either.
    """
  ]
  
  private var heights: [String] = [
    "Chapter 1:\nThe Basics",
    "Chapter 2: Basic Operators",
    "Chapter 3:\nStrings\nand Characters",
    "Chapter 4:\nCollection Types",
    "Chapter 5:\nControl Flow",
    "Chapter 6:\nFunctions",
    "Chapter 7: Closures",
    "Chapter 8: Enumerations",
    "Chapter 9:\nClasses and Structures",
    "Chapter 10:\nProperties",
    "Chapter 11: Methods",
    "Chapter 12: Subscripts",
    "Chapter 13:\nInheritance",
    "Chapter 14: Initialization",
    "Chapter 15: Deinitialization",
    "Chapter 16:\nOptional Chaining",
    "Chapter 17: Error Handling",
    "Chapter 18:\nType Casting",
    "Chapter 19:\nNested Types",
    "Chapter 20: Extensions",
    "Chapter 21: Protocols",
    "Chapter 22: Generics",
    "Chapter 23:\nAutomatic Reference\nCounting",
    "Chapter 24: Memory Safety",
    "Chapter 25: Access Control",
    "Chapter 26:\nAdvanced Operators"
  ]
  
  var horizontalAlignment: TagsView.HorizontalAlignment = .left
  var verticalAlignment: TagsView.VerticalAlignment = .top
  var minimumIntertagSpacing: CGFloat = 8
  
  // MARK: - Initializers

  init(withTitle title: String, mode: Mode, horizontalAlignment: TagsView.HorizontalAlignment, verticalAlignment: TagsView.VerticalAlignment, minimumIntertagSpacing: CGFloat) {
    self.title = title
    self.mode = mode
    self.horizontalAlignment = horizontalAlignment
    self.verticalAlignment = verticalAlignment
    self.minimumIntertagSpacing = minimumIntertagSpacing
  }
  
  static func preferredSize(with contentSize: CGSize, tag: String, at index: Int) -> CGSize {
    return MyTagView.preferredSize(with: contentSize, tag: tag, at: index)
  }
}

// MARK: - TagsViewDataSource
extension TagsViewModel: TagsViewDataSource {
  
  func tagsView(_ tagsView: TagsView, preferredSizeForTagAt index: Int) -> CGSize {
    let tag = self.tags[index]
    return MyTagView.preferredSize(with: tagsView.bounds.size, tag: tag, at: index)
  }
  
  func tagsView(_ tagsView: TagsView, viewForTagAt index: Int) -> UIView {
    let tagView = MyTagView.loadFromNib()
    let tag = self.tags[index]
    tagView.update(with: tag)
    return tagView
  }
}
