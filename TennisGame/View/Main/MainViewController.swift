
import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    weak var coordinator: MainCoordinator!
    
    public var mainView = MainView()
    public var gameStartButton: UIButton!
    public var levelsButton: UIButton!
    public var shopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(LevelManager.shared.getAllLevels())
        configure()
    }
    
    private func configure() {
        setupUI()
        setupButtons()
    }
    
    private func setupUI() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
