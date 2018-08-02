//  MIT License
//
//  Copyright (c) 2018 KTTagsView
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

public protocol TagsViewDataSource: class {
  func tagsView(_ tagsView: TagsView, preferredSizeForTagAt index: Int) -> CGSize
  func tagsView(_ tagsView: TagsView, viewForTagAt index: Int) -> UIView
}

open class TagsView: UIView {

  public enum HorizontalAlignment {
    case left, center, right
  }

  public enum VerticalAlignment {
    case top, center, bottom
  }

  // MARK: Outlets

  // MARK: Properties

  private var nbOfTags: Int = 0
  private var horizontalAlignment: HorizontalAlignment = .left
  private var verticalAlignment: VerticalAlignment = .top
  private var minimumIntertagSpacing: CGFloat = 0
  private var dataSource: TagsViewDataSource?

  // MARK: - Initializers

  // MARK: - Overrides

  override open func layoutSubviews() {
    super.layoutSubviews()

    self.removeAllSubviews()

    guard let dataSource = self.dataSource else { return }
    self.addTags(with: dataSource)
  }

  // MARK: - Public methods

  public static func preferredSize<T: TagsProvider>(with contentSize: CGSize, provider: T) -> CGSize {
    var numberOfRows: Int = 0
    var height: CGFloat = 0
    var rowWidth: CGFloat = provider.minimumIntertagSpacing
    var rowHeight: CGFloat = 0
    for (index, tag) in provider.tags.enumerated() {
      let size = T.preferredSize(with: contentSize, tag: tag, at: index)
      let width = size.width + provider.minimumIntertagSpacing
      let remainingWidth: CGFloat = contentSize.width - rowWidth
      if width <= remainingWidth {
        rowWidth += width
        if rowHeight < size.height {
          rowHeight = size.height
        }
      } else {
        // Handle the edge case of the tag having an entire width (width + spacing) being too large
        let isEmpty = rowWidth == provider.minimumIntertagSpacing
        if (rowWidth + width) >= contentSize.width, isEmpty {
          height = size.height
          rowWidth = provider.minimumIntertagSpacing
          continue
        }
        rowWidth = provider.minimumIntertagSpacing + width
        numberOfRows += 1
        height += rowHeight
        rowHeight = size.height
      }
      let count = provider.tags.count
      if index == count - 1 {
        height += rowHeight
      }
    }
    let margins: CGFloat = CGFloat(numberOfRows + 1) * provider.minimumIntertagSpacing + provider.minimumIntertagSpacing
    return CGSize(width: contentSize.width, height: margins + height)
  }

  public func reloadData<T: TagsProvider>(with provider: T, dataSource: TagsViewDataSource) {
    self.nbOfTags = provider.tags.count
    self.horizontalAlignment = provider.horizontalAlignment
    self.verticalAlignment = provider.verticalAlignment
    self.minimumIntertagSpacing = provider.minimumIntertagSpacing
    self.dataSource = dataSource

    self.setNeedsLayout()
  }

  // MARK: - Actions
}

// MARK: - Private methods
private extension TagsView {

  struct Row {
    let rowHeight: CGFloat
    let tags: [Tag]
  }

  struct Tag {
    let index: Int
    let size: CGSize
    let numberOfRows: Int
    let height: CGFloat
    let rowWidth: CGFloat
  }
  typealias Tags = [Row]

  // swiftlint:disable function_body_length
  func tags(with dataSource: TagsViewDataSource) -> Tags {
    var rows: [Row] = []
    var tags: [Tag] = []
    var numberOfRows: Int = 0
    var height: CGFloat = 0
    var rowWidth: CGFloat = self.minimumIntertagSpacing
    var rowHeight: CGFloat = 0
    for index in 0..<self.nbOfTags {
      var size = dataSource.tagsView(self, preferredSizeForTagAt: index)

      // Make sure the tag's width won't exceed the current width
      size.width = min(size.width, self.bounds.width)

      let width = size.width + self.minimumIntertagSpacing
      let remainingWidth: CGFloat = self.bounds.width - rowWidth

      // Handle the case when the tag can be inserted in the current row
      if width <= remainingWidth {
        let tag = Tag(index: index, size: size, numberOfRows: numberOfRows, height: height, rowWidth: rowWidth)
        tags.append(tag)
        rowWidth += width
        if rowHeight < size.height {
          rowHeight = size.height
        }
      } else {

        // Handle the edge case when the tag has an entire width (width + spacing) being too large
        if (rowWidth + width) >= self.bounds.width, tags.isEmpty {
          let spacing = self.bounds.width - width
          rowWidth = spacing > 0 ? spacing / 2 : 0
          let tag = Tag(index: index, size: size, numberOfRows: numberOfRows, height: height, rowWidth: rowWidth)
          tags.append(tag)
          rowHeight = size.height
          let row = Row(rowHeight: rowHeight, tags: tags)
          rows.append(row)
          tags = []
          numberOfRows += 1
          height += rowHeight
          rowWidth = self.minimumIntertagSpacing
          rowHeight = 0
          continue
        }

        // Handle the case when the tag needs to be inserted in the next row
        let row = Row(rowHeight: rowHeight, tags: tags)
        rows.append(row)
        tags = []
        numberOfRows += 1
        height += rowHeight
        rowWidth = self.minimumIntertagSpacing
        rowHeight = size.height
        let tag = Tag(index: index, size: size, numberOfRows: numberOfRows, height: height, rowWidth: rowWidth)
        tags.append(tag)
        rowWidth += width
      }

      let count = self.nbOfTags
      if index == count - 1 {
        height += rowHeight
      }
    }
    let row = Row(rowHeight: rowHeight, tags: tags)
    rows.append(row)
    return rows
  }
  // swiftlint:enable function_body_length

  func addTags(with dataSource: TagsViewDataSource) {
    switch self.horizontalAlignment {
    case .left:
      self.addTagsLeft(with: dataSource)
    case .center:
      self.addTagsCenter(with: dataSource)
    case .right:
      self.addTagsRight(with: dataSource)
    }
  }

  func addTagsLeft(with dataSource: TagsViewDataSource) {
    let tags: Tags = self.tags(with: dataSource)
    tags.forEach({ row in
      row.tags.forEach({ tag in
        let view = dataSource.tagsView(self, viewForTagAt: tag.index)
        let originY: CGFloat = self.offsetY(withRow: row, tag: tag)
        let origin: CGPoint = CGPoint(x: tag.rowWidth, y: originY)
        let frame = CGRect(origin: origin, size: tag.size)
        self.addSubview(view, with: frame)
      })
    })
  }

  func addTagsCenter(with dataSource: TagsViewDataSource) {
    let tags: Tags = self.tags(with: dataSource)
    tags.forEach({ row in
      let contentWidth = row.tags.map({ $0.size.width }).reduce(0, +)
      let interSpacing: CGFloat = self.minimumIntertagSpacing * CGFloat(row.tags.count - 1)
      let leftRightMargins: CGFloat = self.bounds.width - (contentWidth + interSpacing)
      var offsetX = leftRightMargins / 2
      row.tags.forEach({ tag in
        let view = dataSource.tagsView(self, viewForTagAt: tag.index)
        let originY: CGFloat = self.offsetY(withRow: row, tag: tag)
        let originX = offsetX
        let origin: CGPoint = CGPoint(x: originX, y: originY)
        let frame = CGRect(origin: origin, size: tag.size)
        self.addSubview(view, with: frame)
        offsetX += tag.size.width + self.minimumIntertagSpacing
      })
    })
  }

  func addTagsRight(with dataSource: TagsViewDataSource) {
    let tags: Tags = self.tags(with: dataSource)
    tags.forEach({ row in
      var rowWidth: CGFloat = self.minimumIntertagSpacing
      row.tags.reversed().forEach({ tag in
        let view = dataSource.tagsView(self, viewForTagAt: tag.index)
        let originY: CGFloat = self.offsetY(withRow: row, tag: tag)
        let originX = self.bounds.width - rowWidth - tag.size.width
        let origin: CGPoint = CGPoint(x: originX, y: originY)
        let frame = CGRect(origin: origin, size: tag.size)
        self.addSubview(view, with: frame)
        let width = tag.size.width + self.minimumIntertagSpacing
        rowWidth += width
      })
    })
  }

  func offsetY(withRow row: Row, tag: Tag) -> CGFloat {
    let originY: CGFloat
    let margins: CGFloat = CGFloat(tag.numberOfRows) * self.minimumIntertagSpacing + self.minimumIntertagSpacing
    let rowTop = tag.height + margins
    switch self.verticalAlignment {
    case .top:
      originY = rowTop
    case .center:
      let additionalOffset: CGFloat = (row.rowHeight - tag.size.height) / 2
      originY = rowTop + additionalOffset
    case .bottom:
      let additionalOffset: CGFloat = row.rowHeight - tag.size.height
      originY = rowTop + additionalOffset
    }
    return originY
  }

  func addSubview(_ view: UIView, with frame: CGRect) {
    view.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(view)
    let leading = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: frame.origin.x)
    let top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: frame.origin.y)
    let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: frame.size.width)
    let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: frame.size.height)
    let constraints: [NSLayoutConstraint] = [leading, top, width, height]
    self.addConstraints(constraints)
  }
}

private extension UIView {

  func removeAllSubviews() {
    self.subviews.forEach { subview in
      subview.removeFromSuperview()
    }
  }
}
