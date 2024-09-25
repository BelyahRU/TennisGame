
import Foundation
import UIKit

class ShopView: UIView {
    
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
    
    private let shopLabel: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.LabelImages.shopLabel)
        im.clipsToBounds = true
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    public let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.backButton), for: .normal)
        return button
    }()
    
    private let balanceImageView: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.LabelImages.balanceLabel)
        im.clipsToBounds = true
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    public let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "BULGOGI", size: 22)
        label.textColor = .white
        return label
    }()
    
    public let racketView: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.ShopViews.racketFree)
        im.clipsToBounds = true
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    public let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.leftButton), for: .normal)
        return button
    }()
    
    public let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.rightButton), for: .normal)
        return button
    }()
    
    private let cloudImage: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.ShopViews.cloudView)
        im.clipsToBounds = true
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    public let buyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.buyButton), for: .normal)
        button.isHidden = true
        return button
    }()
    
    public let takeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.takeButton), for: .normal)
        button.isHidden = false
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
        addSubview(backButton)
        addSubview(asteroid1)
        addSubview(asteroid2)
        addSubview(shopLabel)
        addSubview(balanceImageView)
        balanceImageView.addSubview(balanceLabel)
        addSubview(racketView)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(cloudImage)
        addSubview(buyButton)
        addSubview(takeButton)
    }
    
    private func setupConstraints() {
        let screenHeight = DataConstraints.screenHeight
        if screenHeight < 800 {
            backButton.snp.makeConstraints { make in
                make.size.equalTo(60)
                make.top.equalToSuperview().offset(20)
                make.leading.equalToSuperview().offset(20)
            }
            
            shopLabel.snp.makeConstraints { make in
                make.width.equalTo(200)
                make.height.equalTo(60)
                make.centerY.equalTo(backButton.snp.centerY)
                make.leading.equalTo(backButton.snp.trailing).offset(10)
            }
            
            leftButton.snp.makeConstraints { make in
                make.centerY.equalTo(racketView)
                make.leading.equalToSuperview().offset(20)
                make.width.equalTo(43)
                make.height.equalTo(50)
            }
            
            rightButton.snp.makeConstraints { make in
                make.centerY.equalTo(racketView)
                make.trailing.equalToSuperview().offset(-20)
                make.width.equalTo(43)
                make.height.equalTo(50)
            }
            
            buyButton.snp.makeConstraints { make in
                make.width.equalTo(150)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-25)
            }
            
            takeButton.snp.makeConstraints { make in
                make.width.equalTo(150)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-25)
            }
            
        } else {
            backButton.snp.makeConstraints { make in
                make.size.equalTo(60)
                make.top.equalToSuperview().offset(64)
                make.leading.equalToSuperview().offset(20)
            }
            
            shopLabel.snp.makeConstraints { make in
                make.width.equalTo(200)
                make.height.equalTo(60)
                make.top.equalTo(backButton.snp.bottom).offset(-10)
                make.centerX.equalToSuperview()
                
            }
            
            leftButton.snp.makeConstraints { make in
                make.centerY.equalTo(racketView)
                make.leading.equalToSuperview().offset(28)
                make.width.equalTo(43)
                make.height.equalTo(50)
            }
            
            rightButton.snp.makeConstraints { make in
                make.centerY.equalTo(racketView)
                make.trailing.equalToSuperview().offset(-28)
                make.width.equalTo(43)
                make.height.equalTo(50)
            }
            
            buyButton.snp.makeConstraints { make in
                make.width.equalTo(150)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.top.equalTo(cloudImage.snp.bottom).offset(30)
            }
            
            takeButton.snp.makeConstraints { make in
                make.width.equalTo(150)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.top.equalTo(cloudImage.snp.bottom).offset(30)
            }
        }
        mainBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
        asteroid1.snp.makeConstraints { make in
            make.size.equalTo(79)
            make.leading.equalToSuperview().offset(27)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        asteroid2.snp.makeConstraints { make in
            make.size.equalTo(89)
            make.bottom.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.trailing.equalToSuperview().offset(-6)
        }
        
        balanceImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(236)
            make.top.equalTo(shopLabel.snp.bottom).offset(30)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(2)
            make.leading.equalTo(balanceImageView.snp.centerX).offset(10)
        }
        
        racketView.snp.makeConstraints { make in
            make.width.equalTo(201)
            make.height.equalTo(224)
            make.centerX.equalToSuperview()
            make.top.equalTo(balanceImageView.snp.bottom).offset(30)
        }
        
        cloudImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(182)
//            make.height.equalTo(16)
            make.top.equalTo(racketView.snp.bottom).offset(15)
        }
        
    }
}
