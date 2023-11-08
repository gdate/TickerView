// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

final class TickerView: UIView {
    @IBInspectable
    private let animationDuration: TimeInterval = 5.0
    
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
    
    func setText(_ text: String) {
        label.text = text
        label.textColor = textColor
        label.sizeToFit()
        label.frame = CGRect(x: frame.size.width, y: 0, width: label.bounds.width, height: frame.size.height)
    }
    
    func startAnimation() {
        guard !isAnimating else { return }
        resetLabelFrame()
        animateLabel()
        isAnimating = true
    }
    
    func stopAnimation() {
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
}

#if DEBUG
import SwiftUI

struct ViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let tickerView = TickerView(frame: .init(x: 0, y: 0, width: viewController.view.frame.width, height: 44))
        tickerView.backgroundColor = .black
        tickerView.setText("TickerView")
        tickerView.startAnimation()
        viewController.view.addSubview(tickerView)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

#Preview(body: {
    ViewControllerWrapper()
})
#endif
