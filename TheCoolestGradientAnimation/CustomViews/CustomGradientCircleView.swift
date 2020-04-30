import UIKit

class CustomGradientCircleView: UIView {
  struct Constants {
    static let initialWidth: CGFloat = 1400
    static let cornerRadius: CGFloat = Constants.initialWidth / 2
    static let gradientColors: [CGColor] = [
      UIColor.superduperPink.cgColor,
      UIColor.purple.cgColor,
      UIColor.bluCepheus.cgColor
    ]
    static let shrinkDuration: TimeInterval = 3.3
    static let shrinkScale: CGFloat = (UIScreen.main.bounds.width * 0.3) / initialWidth
    static let burstStartScale: CGFloat = Constants.shrinkScale / 10
    static let burstEndScale: CGFloat = Constants.shrinkScale * 1.3
    static let shrinkOptions: AnimationOptions = .curveEaseOut

    static let gradientStartPoint: Double = 0.0
    static let gradientEndPoint: Double = 1.0
    static let gradientSublayerIndex: UInt32 = 0

    static let rotationDuration: TimeInterval = 3
    static let rotationKeyPath: String = "transform.rotation"

    static let spinAnimationKey: String = "spinAnimation"
    static let spinAnimationFromValue: Double = 0
    static let spinAnimationToValue: NSNumber = NSNumber(value: 2.0 * (-1) * Float.pi)
  }

  lazy var gradientLayer: CAGradientLayer = {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = Constants.gradientColors
    gradientLayer.frame = self.bounds
    gradientLayer.startPoint = CGPoint(x: Constants.gradientStartPoint, y: Constants.gradientStartPoint)
    gradientLayer.endPoint = CGPoint(x: Constants.gradientEndPoint, y: Constants.gradientEndPoint)
    return gradientLayer
  }()

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

  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    gradientLayer.frame = self.bounds
  }

  // MARK: - Setup

  private func setupUI() {
    self.gradientLayer.cornerRadius = Constants.cornerRadius
    self.layer.cornerRadius = Constants.cornerRadius
    self.clipsToBounds = false
    self.layer.insertSublayer(self.gradientLayer, at: Constants.gradientSublayerIndex)
  }

  private func setupConstraints() {
    self.translatesAutoresizingMaskIntoConstraints = false

    self.widthAnchor.constraint(equalToConstant: Constants.initialWidth).isActive = true
    self.heightAnchor.constraint(equalToConstant: Constants.initialWidth).isActive = true
  }

  // MARK: - Animation

  func shrink(completion: ((Bool) -> Void)? = nil) {
    self.shrink(duration: Constants.shrinkDuration,
                scale: Constants.shrinkScale,
                options: Constants.shrinkOptions
      ) { _ in
      completion?(true)
    }
  }

  func rotate(completion: ((Bool) -> Void)? = nil) {
    let spinAnimation = CABasicAnimation.init(keyPath: Constants.rotationKeyPath)
    spinAnimation.fromValue = Constants.spinAnimationFromValue
    spinAnimation.toValue = Constants.spinAnimationToValue
    spinAnimation.duration = Constants.rotationDuration
    spinAnimation.repeatCount = .infinity
    self.layer.add(spinAnimation, forKey: Constants.spinAnimationKey)
  }

  func burst(animation: ((Bool) -> Void)? = nil,
             completion: ((Bool) -> Void)? = nil) {
    self.animatePop(
      startScale: Constants.burstStartScale,
      endScale: Constants.burstEndScale,
      animation: { isAnimationCompleted in
        animation?(isAnimationCompleted)
    }, completion: { _ in
      completion?(true)}
    )
  }
}
