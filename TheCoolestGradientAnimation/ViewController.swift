import UIKit
class ViewController: UIViewController {
  struct Constants {
    static let timerSeconds: Double = 5

    static let scaleAnimationKeyPath: String = "transform.scale"
    static let scaleAnimationDuration: Double = 2.0
    static let scaleAnimationfromValue: Double = 0.0
    static let scaleAnimationToValue: Double = 1.0
    static let scaleAnimationKey: String = "scale"
  }

  lazy var overlayView: CustomOverlayView = {
    let frame = self.view.frame
    let view = CustomOverlayView(frame: frame)
    return view
  }()

  lazy var gradientCircleView: CustomGradientCircleView = {
    let view = CustomGradientCircleView()
    return view
  }()

  lazy var circleView: CustomCircleView = {
    let view = CustomCircleView()
    return view
  }()

  lazy var pulseLayers: [CAShapeLayer] = []

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.setupGradientCircleView()
    self.setupCircleView()
    self.setupOverlayView()

    self.overlayView.fadeout { _ in
      self.gradientCircleView.shrink()
      self.circleView.pop()
      self.gradientCircleView.rotate()
      self.perform(#selector(self.performBurstAction), with: nil, afterDelay: Constants.timerSeconds)
    }
  }

  // MARK: - Pulse/Burst

  @objc func performBurstAction() {
    self.circleView.burst()
    self.gradientCircleView.burst(animation: { [weak self] _ in
      self?.createPulse()}
    )
  }

  private func createPulse() {
    for index in 0...3 {
      let circularPath = UIBezierPath(
        arcCenter: .zero,
        radius: UIScreen.main.bounds.width * 1.5,
        startAngle: 0,
        endAngle: 2 * .pi,
        clockwise: true
      )

      let pulseLayer = CAShapeLayer()
      pulseLayer.path = circularPath.cgPath
      pulseLayer.lineWidth = 6.0
      pulseLayer.fillColor = UIColor.clear.cgColor
      pulseLayer.strokeColor = UIColor.purple.cgColor
      pulseLayer.lineCap = CAShapeLayerLineCap.round
      pulseLayer.position = self.view.center
      self.view.layer.insertSublayer(pulseLayer, at: UInt32(index))
      self.pulseLayers.append(pulseLayer)
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      self.animatePulse(index: 0)
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
        self.animatePulse(index: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
          self.animatePulse(index: 2)
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.animatePulse(index: 3)
          }
        }
      }
    }
  }

  private func animatePulse(index: Int) {
    let scaleAnimation = CABasicAnimation(keyPath: Constants.scaleAnimationKeyPath)
    scaleAnimation.duration = Constants.scaleAnimationDuration
    scaleAnimation.fromValue = Constants.scaleAnimationfromValue
    scaleAnimation.toValue = Constants.scaleAnimationToValue
    scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
    scaleAnimation.repeatCount = .infinity
    self.pulseLayers[index].add(scaleAnimation, forKey: Constants.scaleAnimationKey)
  }

  // MARK: - Setup

  private func setupGradientCircleView() {
    self.view.addSubview(self.gradientCircleView)
    self.gradientCircleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    self.gradientCircleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
  }

  private func setupCircleView() {
    self.view.addSubview(self.circleView)
    self.circleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    self.circleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
  }

  private func setupOverlayView() {
    self.view.addSubview(self.overlayView)
  }
}

