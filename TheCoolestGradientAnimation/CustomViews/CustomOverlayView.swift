import UIKit

class CustomOverlayView: UIView {
  struct Constants {
    static let fadeOutDuration: Double = 1.6
  }

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.commonInit()
  }

  private func commonInit() {
    self.backgroundColor = .black
  }

  // MARK: - Animations

  func fadeout(completion: ((Bool) -> Void)? = nil) {
    self.fadeOut(duration: Constants.fadeOutDuration) { _ in
      completion?(true)
    }
  }
}
