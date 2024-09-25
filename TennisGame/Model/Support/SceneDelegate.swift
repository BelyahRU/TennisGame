
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)

        start()
    }
    
    func start() {
        coordinator = MainCoordinator()
        coordinator?.start()
        window?.rootViewController = coordinator?.navigationController //main
        window?.makeKeyAndVisible()
    }

}

