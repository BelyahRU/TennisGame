
import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    weak var coordinator: MainCoordinator!
    
    public var mainView = MainView()
    public var gameStartButton: UIButton!
    public var levelsButton: UIButton!
    public var shopButton: UIButton!
    
    private let loadingView = LoadingView()
    
    override func loadView() {
        super.loadView()
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.configure()
        }
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
