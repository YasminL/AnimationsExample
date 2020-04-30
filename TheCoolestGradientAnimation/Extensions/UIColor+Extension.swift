import UIKit

extension UIColor {
  static let competitionPurple = UIColor.fromHex("6d00ff")
  static let londonSky = UIColor.fromHex("eef0f1")
  static let deepIndigo = UIColor.fromHex("270450")
  static let bluCepheus = UIColor.fromHex("00d2ff")
  static let mexicoBlue = UIColor.fromHex("13a8f1")
  static let osloBlue = UIColor.fromHex("2e7aff")
  static let rubystoneRed = UIColor.fromHex("c31eba")
  static let superPink = UIColor.fromHex("ff4281")
  static let superduperPink = UIColor.fromHex("FF44A7")
  static let purplelicious = UIColor.fromHex("672CB2")
  static let lilacGrey = UIColor.fromHex("7e7687")
  static let powderBlue = UIColor.fromHex("b5c7de")
  static let viola = UIColor.fromHex("9213d5")
  static let pickleGreen = UIColor.fromHex("28c760")

  static func fromHex(_ hex: String?) -> UIColor {
    var rgbValue: UInt64 = 0
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 0.0

    guard let hex = hex else { return UIColor(red: red, green: green, blue: blue, alpha: alpha) }
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    let length = hexSanitized.count

    guard Scanner(string: hexSanitized).scanHexInt64(&rgbValue) else {
      return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    if length == 6 {
      red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
      green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
      blue = CGFloat(rgbValue & 0x0000FF) / 255.0
      alpha = 1
      return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    if length == 8 {
      red = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
      green = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
      blue = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
      alpha = CGFloat(rgbValue & 0x000000FF) / 255.0
      return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
}
