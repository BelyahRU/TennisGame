
import Foundation
import UIKit

class PauseView: UIView {
    
    private let backView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.ViewImages.pauseView)
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    public let resumeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.resumeButton), for: .normal)
        return button
    }()
    
    public let backToMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.ButtonImages.backToMenuButton), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(backView)
        addSubview(resumeButton)
        addSubview(backToMenuButton)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        resumeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-120)
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
        
        backToMenuButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resumeButton.snp.bottom).offset(22)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
}
