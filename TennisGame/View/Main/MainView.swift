
import Foundation
import UIKit
import SnapKit

class MainView: UIView {
    
    private let mainBackground: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.BackgroundImages.mainBackgroundImage)
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    private let asteroid1: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.AsteroidImages.asteroidImage1)
        return im
    }()
    
    private let asteroid2: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.AsteroidImages.asteroidImage2)
        return im
    }()
    
    private let winTennisProLabel: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.LabelImages.winTennisProLabel)
        return im
    }()
    
    public let gameStartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.gameStartButton), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(mainBackground)
        addSubview(asteroid1)
        addSubview(asteroid2)
        addSubview(winTennisProLabel)
        addSubview(gameStartButton)
    }
    
    private func setupConstraints() {
        mainBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        asteroid1.snp.makeConstraints { make in
            make.size.equalTo(66)
            make.top.equalToSuperview().offset(81)
            make.leading.equalToSuperview().offset(19)
        }
        
        asteroid2.snp.makeConstraints { make in
            make.size.equalTo(66)
            make.top.equalToSuperview().offset(247)
            make.trailing.equalToSuperview().offset(-27)
        }
        
        winTennisProLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(73)
        }
        
        gameStartButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
    }
}
