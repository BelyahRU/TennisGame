
import Foundation
import UIKit

final class LevelsViewController: UIViewController {
    
    weak var levelsCoordinator: LevelsCoordinator!
    
    public let levelsView = LevelsView()
    
    public var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupCollectionView()
        setupButton()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(levelsView)
        
        levelsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
