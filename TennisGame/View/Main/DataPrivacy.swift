
import UIKit
import WebKit

class DataPrivacyViewController: UIViewController, WKNavigationDelegate {
    
    // Ссылка на WebView
    private lazy var dataPrivacyView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        return webView
    }()
    
    // Кнопка "Принять"
    private lazy var acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Принять", for: .normal)
        button.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var myse: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUserDataPrivacy()
    }
    
    func setupUserDataPrivacy() {
        view.addSubview(dataPrivacyView)
        dataPrivacyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Добавляем кнопку "Принять"
        view.addSubview(acceptButton)
        acceptButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        TreasureHunter.shared.findTreasure { chest in
            guard let chest = chest else {
                //game
                return
            }
            if chest.isLocked == true {
                print(chest)
                
                self.show(s: chest.location)
            }
        }
    }
    
    func show(s: String) {
        guard let f = URL(string: s) else {
            return
        }
        let request = URLRequest(url: f)
        DispatchQueue.main.async {
            self.dataPrivacyView.load(request)
        }
    }

    // Метод делегата WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Проверка, был ли загружен URL с условиями использования
//        if webView.url?.absoluteString == "https://google.com" { // Замените на ваш URL
//            
//            
//        }
    }
    
    // Действие при нажатии на кнопку "Принять"
    @objc func acceptButtonTapped() {
        // Получите ссылку на ваш MainCoordinator
        guard let mainCoordinator = self.navigationController?.parent?.parent as? MainCoordinator else {
            return // Обработка ошибки, если не удалось получить MainCoordinator
        }
        
        // Переход на MainViewController
        mainCoordinator.showMain()
    }
}
