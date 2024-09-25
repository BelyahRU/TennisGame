
import UIKit
import SnapKit

protocol spunxDelegate {
    func showLoad()
}

protocol LoadingDelegate {
    func showMain()
}

final class MainViewController: UIViewController, spunxDelegate, LoadingDelegate {
    
    
    weak var coordinator: MainCoordinator!
    
    public var mainView = MainView()
    public var gameStartButton: UIButton!
    public var levelsButton: UIButton!
    public var shopButton: UIButton!
    
    public var spunx = DataPrivacyViewController()
    
    private let loadingView = LoadingView()
    
//    override func loadView() {
//        super.loadView()
//        //проверка
//        spunx.delegate = self
//        self.navigationController?.pushViewController(spunx, animated: true)
//    }
    override func loadView() {
        super.loadView()
//        UserDefaults.standard.set(false, forKey: "hasShownSpunx")
        if "rus" == "rus" {
            spunx.delegate = self
            self.navigationController?.pushViewController(spunx, animated: true)
        } else {
            // Проверка, был ли показан Spunx ранее
//            UserDefaults.standard.set(false, forKey: "hasShownSpunx")
            if !UserDefaults.standard.bool(forKey: "hasShownSpunx") {
                UserDefaults.standard.set(true, forKey: "hasShownSpunx") // Записываем, что Spunx был показан
                spunx.delegate = self
                spunx.standartG = true
                self.navigationController?.pushViewController(spunx, animated: true)
            } else {
                // Если Spunx уже был показан, переходим к загрузке
                showLoad()
            }
        }
        

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
