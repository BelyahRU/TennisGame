

import Foundation
import UIKit

class ShieldLoadingView: UIView {
    
    private let shieldImage: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.ItemImages.shield)
        im.isHidden = true
        return im
    }()
    
    private var timerCounter: Int = 5
    private var timer: Timer?
    
    private let shieldTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.isHidden = true
        label.font = UIFont(name: "BULGOGI", size: 14)
        label.textColor = UIColor(red: 253/255, green: 187/255, blue: 38/255, alpha: 1.0)
        return label
    }()
    
    public lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor(red: 255/255, green: 1/255, blue: 2/255, alpha: 1.0)
        progressView.isHidden = true
        progressView.layer.cornerRadius = 8
        progressView.layer.masksToBounds = true
        progressView.trackTintColor = .white
        progressView.backgroundColor = .clear
        progressView.setProgress(0.0, animated: false)
        progressView.layer.borderWidth = 2
        progressView.layer.borderColor = UIColor(red: 253/255, green: 187/255, blue: 38/255, alpha: 1.0) .cgColor
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupView()
    }
    
    private func setupView() {
        addSubview(progressView)
        addSubview(shieldImage)
        addSubview(shieldTimerLabel)
        
        progressView.snp.makeConstraints { make in
            make.centerX.top.bottom.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(204)
            make.centerY.equalToSuperview()
        }
        
        shieldImage.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        shieldTimerLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.size.equalTo(16)
            make.centerY.equalToSuperview()
        }
    }
    
    public func showShield() {
        progressView.layoutIfNeeded()
        progressView.progress = 0.0
        progressView.isHidden = false
        shieldImage.isHidden = false
        shieldTimerLabel.isHidden = false
        
        progressView.progressTintColor = UIColor(red: 255/255, green: 1/255, blue: 2/255, alpha: 1.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.progressView.isHidden = true
            self.shieldImage.isHidden = true
            self.shieldTimerLabel.isHidden = true
            self.timerCounter = 5
            self.shieldTimerLabel.text = String(self.timerCounter)
            self.progressView.setProgress(0.0, animated: false)
            
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timerCounter -= 1
            self.shieldTimerLabel.text = String(self.timerCounter)
            // Проверяем, когда таймер достиг 0
            if self.timerCounter == 0 {
                timer.invalidate() // Останавливаем таймер
                // Дополнительный код для окончания обратного отсчета
            }
        }

        UIView.animate(withDuration: 5, animations: {
            self.progressView.setProgress(1.0, animated: true)
        })
    }
}
