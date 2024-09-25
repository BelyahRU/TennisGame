
import UIKit
import SnapKit


protocol LoadingDelegate {
    func showMain()
}

final class MainViewController: UIViewController, LoadingDelegate {
    
    
    weak var coordinator: MainCoordinator!
    
    public var mainView = MainView()
    public var gameStartButton: UIButton!
    public var levelsButton: UIButton!
    public var shopButton: UIButton!
    
    
    private let loadingView = LoadingView()
    
    override func loadView() {
        super.loadView()
        showLoad()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func showMain() {
        configure()
    }
    
    func showLoad() {
        view.addSubview(loadingView)
        loadingView.delegate = self
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadingView.setupLoading()
    }
    
}
