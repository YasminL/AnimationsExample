import UIKit

class CustomCircleView: UIView {
  struct Constants {
    static let initialWidth: CGFloat = 10
    static let cornerRadius: CGFloat = Constants.initialWidth / 2
    static let border: CGFloat = 8
    static let popDuration: TimeInterval = 2.8
    static let popScale: CGFloat = ((UIScreen.main.bounds.width * 0.3) - Constants.border) / Constants.initialWidth
    static let burstStartScale: CGFloat = Constants.popScale / 10
    static let burstEndScale: CGFloat = Constants.popScale * 1.3
    static let popOptions: AnimationOptions = .curveEaseIn
  }

  // MARK: - Initialization

  convenience init(width: Double) {
    self.init(frame: .zero)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.commonInit()
  }

  private func commonInit() {
    self.setupUI()
    self.setupConstraints()
  }

  // MARK: - Setup

  private func setupUI() {
    self.isHidden = true
    self.backgroundColor = .black
    self.layer.cornerRadius = Constants.cornerRadius
    self.clipsToBounds = false
  }

  private func setupConstraints() {
    self.translatesAutoresizingMaskIntoConstraints = false

    self.widthAnchor.constraint(equalToConstant: Constants.initialWidth).isActive = true
    self.heightAnchor.constraint(equalToConstant: Constants.initialWidth).isActive = true
  }

  // MARK: - Animation
  
  func pop(completion: ((Bool) -> Void)? = nil) {
    self.fadeIn { _ in
      self.shrink(
        duration: Constants.popDuration,
        scale: Constants.popScale,
        options: Constants.popOptions) { _ in
          completion?(true)
      }
    }
  }

  func burst(completion: ((Bool) -> Void)? = nil) {
    self.animatePop(startScale: Constants.burstStartScale, endScale: Constants.burstEndScale) { _ in
      completion?(true)
    }
  }
}
