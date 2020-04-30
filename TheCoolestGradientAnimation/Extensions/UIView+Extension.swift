import UIKit

extension UIView {

  // MARK: - Animations

  func fadeIn(duration: TimeInterval = 0.5, completion: ((Bool) -> Void)? = nil) {
    self.isHidden = false
    self.alpha = 0
    self.layoutIfNeeded()

    UIView.animate(
      withDuration: duration,
      animations: { [weak self] in
        self?.alpha = 1.0
        self?.layoutIfNeeded()
      }, completion: { isCompleted in
        completion?(isCompleted)
      }
    )
  }

  func fadeOut(duration: TimeInterval = 0.5, completion: ((Bool) -> Void)? = nil) {
    self.alpha = 1
    self.layoutIfNeeded()

    UIView.animate(
      withDuration: duration,
      animations: { [weak self] in
        self?.alpha = 0
        self?.layoutIfNeeded()
      }, completion: { isCompleted in
        self.isHidden = true
        completion?(isCompleted)}
    )
  }

  func shrink(duration: TimeInterval = 1.0,
              scale: CGFloat,
              options: AnimationOptions,
              completion: ((Bool) -> Void)? = nil) {
    UIView.animate(
      withDuration: duration,
      delay: 0,
      options: options,
      animations: { [weak self] in
        self?.transform = CGAffineTransform(scaleX: scale, y: scale)
      },
      completion: { isCompleted in
        completion?(isCompleted)
    })
  }

  func animatePop(startScale: CGFloat,
                  endScale: CGFloat,
                  duration: TimeInterval = 2.0,
                  animation: ((Bool) -> Void)? = nil,
                  completion: ((Bool) -> Void)? = nil) {
    self.transform = CGAffineTransform(scaleX: startScale, y: startScale)

    UIView.animate(
      withDuration: duration,
      delay: 0,
      usingSpringWithDamping: 0.2,
      initialSpringVelocity: 6.0,
      options: .allowUserInteraction,
      animations: { [weak self] in
        self?.transform = CGAffineTransform(scaleX: endScale, y: endScale)
        animation?(true)
      },
      completion: { isCompleted in
        completion?(isCompleted)}
    )
  }
}
