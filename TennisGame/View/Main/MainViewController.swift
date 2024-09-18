
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    weak var coordinator: MainCoordinator!
    
    public var mainView = MainView()
    public var gameStartButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    

}
