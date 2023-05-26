//
//  LoadingView.swift

import UIKit
import Lottie

class LoadingView: UIView {
    
    let animateLoading = LottieAnimationView()
    
    init() {
        super.init(frame: .zero)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepare() {
        backgroundColor = .black.withAlphaComponent(0.1)
        
        animateLoading.animation = LottieAnimation.named("loading")
        animateLoading.loopMode = .loop
        
        animateLoading.contentMode = .scaleAspectFill
        animateLoading.layer.cornerRadius = 8
        animateLoading.backgroundColor = .white
    }
    
    func showAdded(to view: UIView) {
        view.addSubview(self)
        self.frame = view.bounds
        addSubviews(animateLoading)
        
        animateLoading.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.center.equalToSuperview()
        }
        animateLoading.play()
    }
    
    func hide() {
        self.removeFromSuperview()
        animateLoading.stop()
    }
}
