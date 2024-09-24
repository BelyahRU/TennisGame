
import Foundation
import UIKit

class GameOverView: UIView {
    
    
    private let backView: UIImageView = {
       let im = UIImageView()
//        im.image = UIImage(named: Resources.ViewImages.pauseView)
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BULGOGI", size: 34)
        return label
    }()
    
    public let restartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.restartButtonBig), for: .normal)
        return button
    }()
    
    public let nextLevelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.nextLevelButton), for: .normal)
        return button
    }()
    
    public let backToMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.backToMenuButton), for: .normal)
        return button
    }()
    
    var stars: Int
    var scores: Int
    
    init(stars: Int, scores: Int) {
        self.stars = stars
        self.scores = scores
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(backView)
        addSubview(backToMenuButton)
        addSubview(scoreLabel)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backToMenuButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(28)
        }
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }
        
        scoreLabel.text = String(scores)
        if stars == 0 {
            backView.image = UIImage(named: Resources.ViewImages.levelFailed)
            addSubview(restartButton)
            restartButton.snp.makeConstraints { make in
                make.width.equalTo(200)
                make.height.equalTo(60)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(backToMenuButton.snp.top).offset(-20)
            }
        } else {
            switch stars {
            case 1:
                backView.image = UIImage(named: Resources.ViewImages.levelCompletedWith1Star)
            case 2:
                backView.image = UIImage(named: Resources.ViewImages.levelCompletedWith2Star)
            default:
                backView.image = UIImage(named: Resources.ViewImages.levelCompletedWith3Star)
            }
            addSubview(nextLevelButton)
            nextLevelButton.snp.makeConstraints { make in
                make.width.equalTo(200)
                make.height.equalTo(60)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(backToMenuButton.snp.top).offset(-20)
            }
            
        }
//        addSubview(backView)
//        addSubview(resumeButton)
//        addSubview(backToMenuButton)
//        
//        backView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        resumeButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-120)
//            make.height.equalTo(60)
//            make.width.equalTo(200)
//        }
//        
//        backToMenuButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(resumeButton.snp.bottom).offset(22)
//            make.height.equalTo(50)
//            make.width.equalTo(150)
//        }
    }
}
