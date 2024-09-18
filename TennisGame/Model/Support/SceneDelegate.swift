
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        start()
    }
    
    func start() {
        let coordinator = MainCoordinator()
        coordinator.start()
        window?.rootViewController = coordinator.navigationController //main
        window?.makeKeyAndVisible()
    }

}

