// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Button {
    internal enum Name {
      /// Старт
      internal static let start = L10n.tr("Localizable", "Button.name.start")
      /// Стоп
      internal static let stop = L10n.tr("Localizable", "Button.name.stop")
    }
  }

  internal enum Error {
    /// Ошибка
    internal static let error = L10n.tr("Localizable", "Error.error")
    /// Неправильное название таймера или введен неверный период его работы
    internal static let fail = L10n.tr("Localizable", "Error.fail")
  }

  internal enum Item {
    /// Выполненно
    internal static let completed = L10n.tr("Localizable", "Item.completed")
    /// Таймер закончил работу и удален
    internal static let deleted = L10n.tr("Localizable", "Item.deleted")
    /// Мультитаймер
    internal static let title = L10n.tr("Localizable", "Item.title")
    /// Неправильное значение
    internal static let wrongValue = L10n.tr("Localizable", "Item.wrongValue")
  }

  internal enum Text {
    /// Введите имя таймера
    internal static let enterTimerName = L10n.tr("Localizable", "text.enterTimerName")
    /// Введите время
    internal static let enterTimerTime = L10n.tr("Localizable", "text.enterTimerTime")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
