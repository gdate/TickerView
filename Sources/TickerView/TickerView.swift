/**
 TickerView - Text Animation Scroller

 The TickerView library provides the following features for animating text from right to left.

 Features:
 - Text that goes off-screen is automatically hidden.
 - When all text is hidden, it resets to the initial position and the animation restarts.
 - Text size is optimized based on the label's height.
 - Users can set the text and start/stop the animation.
 - If the text width exceeds the scrollView's width, the text animates within the scrollable area.

 Author: gdate
 License: This library is provided under the MIT License. Please refer to the LICENSE file for details.

 Usage Example:
 ```swift
 import TickerView
 
 let viewController = UIViewController()
 let tickerView = TickerView(frame: .init(x: 0, y: 0, width: viewController.view.frame.width, height: 44))
 tickerView.backgroundColor = .black
 tickerView.setText("TickerView")
 tickerView.startAnimation()
 viewController.view.addSubview(tickerView)
 ```
 
 Contact:
 - GitHub: https://github.com/gdate/TickerView
 - Email: guiltyapi01@gmail.com
 
 Version: 1.0.0
 Last Updated: 2023-11-08
 */

import UIKit

/// TickerView is the main class responsible for animating text horizontally from right to left within a UIScrollView.
public final class TickerView: UIView {
    @IBInspectable
    private var animationDuration: Double = 5.0
    
    @IBInspectable
    private var useTextAutoSizing: Bool = false
    
    @IBInspectable
    private var textSize: Double = 17.0
    
    @IBInspectable
    private var textColor: UIColor = .white
    
    private let scrollView = UIScrollView()
    private let label = UILabel()
    private var isAnimating = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScrollView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureScrollView()
    }
    
    /// Sets the text to be displayed in the scrolling animation view.
    /// - Parameter text: The text to be displayed in the animation view.
    public func setText(_ text: String) {
        label.text = text
        label.textColor = textColor
        label.textAlignment = .left
        adjustLabelFontSize()
    }
    
    /// Starts the scrolling animation of the text within the view.
    /// Call this method to begin the animation that makes the text scroll from right to left.
    public func startAnimation() {
        guard !isAnimating else { return }
        resetLabelFrame()
        animateLabel()
        isAnimating = true
    }
    
    /// Stops the currently running scrolling animation.
    /// Call this method to halt the scrolling animation of the text within the view.
    public func stopAnimation() {
        label.layer.removeAllAnimations()
        isAnimating = false
    }
    
    private func configureScrollView() {
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: frame.size.width, height: frame.size.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        scrollView.addSubview(label)
        addSubview(scrollView)
    }
    
    private func resetLabelFrame() {
        label.frame.origin.x = frame.size.width
    }
    
    private func animateLabel() {
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: [.curveLinear],
            animations: {
                self.label.frame.origin.x = -self.label.bounds.width
            }) { [weak self] completed in
                guard completed else { return }
                self?.resetLabelFrame()
                self?.animateLabel()
            }
    }
    
    private func adjustLabelFontSize() {
        if useTextAutoSizing {
            label.font = label.font.withSize(frame.size.height)
        } else {
            label.font = .systemFont(ofSize: textSize)
            let labelHeight = label.font.pointSize
            let maxHeight = frame.size.height
            if labelHeight > maxHeight {
                label.font = label.font.withSize(frame.size.height)
            }
        }
        let labelSize = label.intrinsicContentSize
        label.frame = CGRect(x: frame.size.width, y: 0, width: labelSize.width, height: frame.size.height)
    }
}

extension TickerView {
    struct Configuration {
        let animationDuration: Double?
        let useTextAutoSizing: Bool?
        let textSize: Double?
        let textColor: UIColor?
    }
    
    func inject(configuraiton: Configuration) {
        if let animationDuration = configuraiton.animationDuration {
            self.animationDuration = animationDuration
        }
        if let useTextAutoSizing = configuraiton.useTextAutoSizing {
            self.useTextAutoSizing = useTextAutoSizing
        }
        if let textSize = configuraiton.textSize {
            self.textSize = textSize
        }
        if let textColor = configuraiton.textColor {
            self.textColor = textColor
        }
    }
}

#if DEBUG
import SwiftUI

struct ViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    let configuration: TickerView.Configuration
    
    init(configuration: TickerView.Configuration) {
        self.configuration = configuration
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let tickerView = TickerView(frame: .init(x: 0, y: 0, width: viewController.view.frame.width, height: 44))
        tickerView.backgroundColor = .black
        tickerView.inject(configuraiton: configuration)
        tickerView.setText("The TickerView library provides the following features for animating text from right to left.")
        tickerView.startAnimation()
        viewController.view.addSubview(tickerView)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
struct TickerViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerWrapper(configuration: .init(
                animationDuration: 1,
                useTextAutoSizing: false,
                textSize: nil,
                textColor: nil)).previewDisplayName("AnimationDuration 1")
            ViewControllerWrapper(configuration: .init(
                animationDuration: nil,
                useTextAutoSizing: false,
                textSize: nil,
                textColor: nil)).previewDisplayName("AutoSizing False")
            ViewControllerWrapper(configuration: .init(
                animationDuration: nil,
                useTextAutoSizing: true,
                textSize: nil,
                textColor: nil)).previewDisplayName("AutoSizing True")
            ViewControllerWrapper(configuration: .init(
                animationDuration: nil,
                useTextAutoSizing: false,
                textSize: 11,
                textColor: nil)).previewDisplayName("TextSize 11")
            ViewControllerWrapper(configuration: .init(
                animationDuration: nil,
                useTextAutoSizing: false,
                textSize: 100,
                textColor: nil)).previewDisplayName("TextSize 100")
            ViewControllerWrapper(configuration: .init(
                animationDuration: nil,
                useTextAutoSizing: false,
                textSize: nil,
                textColor: .gray)).previewDisplayName("TextColor Gray")
        }
    }
}
#endif
