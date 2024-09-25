
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        start()
    }
    
    func start() {
        coordinator = MainCoordinator()
        coordinator?.start()
        window?.rootViewController = DataPrivacyViewController()
//        window?.rootViewController = coordinator?.navigationController //main
        window?.makeKeyAndVisible()
    }

}

