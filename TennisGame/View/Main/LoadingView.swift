
import Foundation
import UIKit

class LoadingView: UIView {
    
    private let loadingBackground: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.BackgroundImages.loadingBackground)
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    public var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor(red: 59/255, green: 0/255, blue: 224/255, alpha: 1.0)
        progressView.layer.cornerRadius = 16
        progressView.layer.masksToBounds = true
        progressView.trackTintColor = .white
        progressView.backgroundColor = .clear
        progressView.setProgress(0.0, animated: false)
        progressView.layer.borderWidth = 2
        progressView.layer.borderColor = UIColor.white.cgColor
        return progressView
    }()
    
    private var timer: Timer?
    private var timerCounter: Int = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupSubviews()
        setupConstaints()
        setupLoading()
    }
    
    private func setupSubviews() {
        addSubview(loadingBackground)
        addSubview(progressView)
    }
    
    private func setupConstaints() {
        loadingBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.width.equalTo(283)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-120)
        }
        
    }
    
    public func setupLoading() {
        progressView.layoutIfNeeded()
        progressView.progress = 0.001
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timerCounter -= 1
            if self.timerCounter == 0 {
                timer.invalidate()
            }
        }
        UIView.animate(withDuration: 5, animations: {
            self.progressView.setProgress(1.0, animated: true)
        })
    }
}
