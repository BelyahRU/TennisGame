
import Foundation
import UIKit

final class LevelCell: UICollectionViewCell {
    
    static let reuseId = "LevelCell"
    
    let levelImage: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: Resources.LevelImages.levelBlocked)
        return im
    }()
    
    let levelText: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.font = UIFont(name: "BULGOGI", size: 52)
        label.text = "1"
        label.textColor = Resources.Colors.blockedLevelGrayText
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        backgroundColor = .clear
        contentView.addSubview(levelImage)
        contentView.addSubview(levelText)
        
        levelImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        levelText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
    }
}

extension LevelCell {
    public func setupCell(level: Level) {
        levelText.text = String(level.num)
        
        if !level.isLocked {
            levelText.textColor = .white
            switch level.stars {
            case 1:
                levelImage.image = UIImage(named: Resources.LevelImages.levelPassed1Star)
            case 2:
                levelImage.image = UIImage(named: Resources.LevelImages.levelPassed2Star)
            case 3:
                levelImage.image = UIImage(named: Resources.LevelImages.levelPassed3Star)
            default:
                levelImage.image = UIImage(named: Resources.LevelImages.levelOpened)
            }
        } else {
            levelImage.image = UIImage(named: Resources.LevelImages.levelBlocked)
            levelText.textColor = Resources.Colors.blockedLevelGrayText
        }
        
    }
}
