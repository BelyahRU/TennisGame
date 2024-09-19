
import Foundation
import UIKit
import SnapKit

final class MainView: UIView {
    
    private let mainBackground: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.BackgroundImages.mainBackgroundImage)
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    private let asteroid1: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.AsteroidImages.asteroidImage1)
        im.clipsToBounds = true
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    private let asteroid2: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.AsteroidImages.asteroidImage2)
        im.clipsToBounds = true
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    private let winTennisProLabel: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.LabelImages.winTennisProLabel)
        im.clipsToBounds = true
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    public let gameStartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.gameStartButton), for: .normal)
        return button
    }()
    
    public let levelsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.levelsButton), for: .normal)
        return button
    }()
    
    public let shopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.shopButton), for: .normal)
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
        addSubview(levelsButton)
        addSubview(shopButton)
    }
    
    private func setupConstraints() {
        if DataConstraints.screenHeight / 2 - 30 < 73 + 230 {
            asteroid1.snp.makeConstraints { make in
                make.size.equalTo(66)
                make.top.equalToSuperview().offset(20)
                make.leading.equalToSuperview().offset(19)
            }
            
            asteroid2.snp.makeConstraints { make in
                make.size.equalTo(66)
                make.top.equalToSuperview().offset(247)
                make.trailing.equalToSuperview().offset(-27)
            }
            
            winTennisProLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(30)
                make.height.equalTo(230)
            }
        } else {
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
                make.height.equalTo(230)
            }
        }
        mainBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        gameStartButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
        shopButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(97)
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        levelsButton.snp.makeConstraints { make in
            make.bottom.equalTo(shopButton.snp.top).offset(-42)
            make.centerX.equalToSuperview()
            make.height.equalTo(shopButton.snp.height)
            make.width.equalTo(shopButton.snp.width)
        }
        
        
    }
}
