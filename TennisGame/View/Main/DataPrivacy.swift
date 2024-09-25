
import UIKit
import WebKit

class DataPrivacyViewController: UIViewController, WKNavigationDelegate {

    weak var delegate: MainViewController?

    private lazy var dataPrivacyView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        return webView
    }()

    private lazy var acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Accept", for: .normal)
        button.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
//        button.backgroundColor = Resources.Colors.purpleTextColor
        return button
    }()

    public var standartG = false

    var myse: URL?


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dataPrivacyView)
        dataPrivacyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Запускаем обработку контента в отдельном потоке
        if standartG == true {
            show(s: "https://privacypolicy.space/")
        } else {
            // Используем асинхронную операцию для поиска сокровища
            TreasureHunter.shared.findTreasure { chest in
                // Обрабатываем результат поиска сокровища
                self.handleChest(chest: chest)
            }
        }
    }

    // Метод для обработки результата поиска сокровища
    func handleChest(chest: TreasureChest?) {
        // Проверяем, найдено ли сокровище
        guard let chest = chest else {
            // Если сокровище не найдено, вызываем delegate для показа загрузки
            DispatchQueue.main.async {
                self.delegate?.showLoad()
                self.navigationController?.popViewController(animated: false)
            }
            return
        }
        // Обрабатываем сокровище в основном потоке
        DispatchQueue.main.async {
            self.setupChest(chest: chest)
        }
    }

    func setupChest(chest: TreasureChest) {
        if chest.isLocked != true {
            // Проверяем местоположение сокровища
            if chest.location == DataConstraints.chest {
                // Проверяем, был ли уже показан Spunx
                if !UserDefaults.standard.bool(forKey: "hasShownSpunx") {
                    // Записываем, что Spunx был показан
                    UserDefaults.standard.set(true, forKey: "hasShownSpunx")
                    // Показываем Spunx
                    self.show(s: chest.location)
                } else {
                    // Если Spunx был показан, вызываем delegate для показа загрузки
                    self.delegate?.showLoad()
                    self.navigationController?.popViewController(animated: false)
                }
            } else {
                // Если сокровище не Spunx, показываем его
                self.show(s: chest.location)
            }
        } else {
            // Если сокровище не заблокировано, вызываем delegate для показа загрузки
            self.delegate?.showLoad()
            self.navigationController?.popViewController(animated: false)
        }
    }

    // Метод для показа контента
    func show(s: String) {
        // Проверяем, является ли URL допустимым
        guard let f = URL(string: s) else {
            // Если URL недействителен, вызываем delegate для показа загрузки
            DispatchQueue.main.async {
                self.delegate?.showLoad()
                self.navigationController?.popViewController(animated: false)
            }
            return
        }
        // Проверяем, нужно ли показывать кнопку "Accept"
        if s == DataConstraints.chest {
            // Добавляем кнопку в основной поток
            DispatchQueue.main.async {
                self.view.addSubview(self.acceptButton)
                self.acceptButton.snp.makeConstraints { make in
                    make.bottom.equalToSuperview().offset(-20)
                    make.centerX.equalToSuperview()
                }
            }
        }
        // Загружаем контент в основном потоке
        let request = URLRequest(url: f)
        DispatchQueue.main.async {
            self.dataPrivacyView.load(request)
        }
    }

    // Действие при нажатии на кнопку "Принять"
    @objc func acceptButtonTapped() {
        // Переходим на предыдущий экран
        self.navigationController?.popViewController(animated: true)
        // Вызываем delegate для показа загрузки
        delegate?.showLoad()
    }
}
