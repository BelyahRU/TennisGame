
import Foundation
import UIKit

final class LevelsView: UIView {
    
    private let backgroundImageView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.BackgroundImages.mainBackgroundImage)
        return im
    }()
    
    private let levelsLabel: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.LabelImages.levelsLabel)
        im.clipsToBounds = true
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    private let aster1Image: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.AsteroidImages.asteroidImage1)
        im.clipsToBounds = true
        im.contentMode = .scaleAspectFit
         return im
    }()
    
    private let aster2Image: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.AsteroidImages.asteroidImage2)
        im.clipsToBounds = true
        im.contentMode = .scaleAspectFit
         return im
    }()
    
    public let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.backButton), for: .normal)
        return button
    }()
    
    public let levelsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupSubivews()
        setupConstraints()
    }
    
    private func setupSubivews() {
        addSubview(backgroundImageView)
        addSubview(levelsLabel)
        addSubview(aster1Image)
        addSubview(aster2Image)
        addSubview(backButton)
        addSubview(levelsCollectionView)
    }
    
    private func setupConstraints() {
        let screenHeight = DataConstraints.screenHeight
        let topOffset: CGFloat = 50
        let collectionViewHeight: CGFloat = 491 
        
        //for small screens
        if screenHeight - collectionViewHeight < 124 {
            backButton.snp.makeConstraints { make in
                make.size.equalTo(60)
                make.top.equalToSuperview().offset(10)
                make.leading.equalToSuperview().offset(20)
            }
            
            levelsLabel.snp.makeConstraints { make in
                make.width.equalTo(200)
                make.height.equalTo(60)
                make.centerY.equalTo(backButton.snp.centerY)
                make.leading.equalTo(backButton.snp.trailing).offset(10)
                
            }
            aster1Image.removeFromSuperview()
            aster2Image.removeFromSuperview()
        } else {
            backButton.snp.makeConstraints { make in
                make.size.equalTo(60)
                make.top.equalToSuperview().offset(64)
                make.leading.equalToSuperview().offset(20)
            }
            
            levelsLabel.snp.makeConstraints { make in
                make.width.equalTo(200)
                make.height.equalTo(60)
                make.top.equalTo(backButton.snp.bottom).offset(-10)
                make.centerX.equalToSuperview()
                
            }
            
            aster1Image.snp.makeConstraints { make in
                make.size.equalTo(79)
                make.leading.equalToSuperview().offset(27)
                make.bottom.equalToSuperview().offset(-5)
            }
            
            aster2Image.snp.makeConstraints { make in
                make.size.equalTo(89)
                make.bottom.equalToSuperview()
                make.bottom.equalToSuperview().offset(-50)
                make.trailing.equalToSuperview().offset(-6)
            }

        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let bottomSpaceNeeded: CGFloat = topOffset + collectionViewHeight + 50 + 80  // space from levelsLabel to bottom
        if bottomSpaceNeeded > screenHeight {
            levelsCollectionView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(5)
                make.height.equalTo(collectionViewHeight)
                make.width.equalTo(338)
            }
            
        } else {
            levelsCollectionView.snp.makeConstraints { make in
                make.top.equalTo(levelsLabel.snp.bottom).offset(topOffset)
                make.centerX.equalToSuperview()
                make.height.equalTo(collectionViewHeight)
                make.width.equalTo(338)
            }
        }
        
    }
}

