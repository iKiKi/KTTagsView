// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {
  /// Tags aligned left
  internal static let case1 = L10n.tr("Localizable", "case1")
  /// Tags aligned center
  internal static let case2 = L10n.tr("Localizable", "case2")
  /// Tags aligned right
  internal static let case3 = L10n.tr("Localizable", "case3")
  /// Single tag entire width
  internal static let case4 = L10n.tr("Localizable", "case4")
  /// Tags with different heights aligned left | top
  internal static let case5 = L10n.tr("Localizable", "case5")
  /// Tags with different heights aligned center | top
  internal static let case6 = L10n.tr("Localizable", "case6")
  /// Tags with different heights aligned right | top
  internal static let case7 = L10n.tr("Localizable", "case7")
  /// Tags with different heights aligned left | center
  internal static let case8 = L10n.tr("Localizable", "case8")
  /// Tags with different heights aligned left | bottom
  internal static let case9 = L10n.tr("Localizable", "case9")
  /// KTTagsView
  internal static let pod = L10n.tr("Localizable", "pod")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
