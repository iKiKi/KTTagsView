// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {
  /// Tags aligned left
  static let case1 = L10n.tr("Localizable", "case1")
  /// Tags aligned center
  static let case2 = L10n.tr("Localizable", "case2")
  /// Tags aligned right
  static let case3 = L10n.tr("Localizable", "case3")
  /// Single tag entire width
  static let case4 = L10n.tr("Localizable", "case4")
  /// Tags with different heights aligned left | top
  static let case5 = L10n.tr("Localizable", "case5")
  /// Tags with different heights aligned center | top
  static let case6 = L10n.tr("Localizable", "case6")
  /// Tags with different heights aligned right | top
  static let case7 = L10n.tr("Localizable", "case7")
  /// Tags with different heights aligned left | center
  static let case8 = L10n.tr("Localizable", "case8")
  /// Tags with different heights aligned left | bottom
  static let case9 = L10n.tr("Localizable", "case9")
  /// KTTagsView
  static let pod = L10n.tr("Localizable", "pod")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
