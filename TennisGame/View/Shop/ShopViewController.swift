
import Foundation
import UIKit

class ShopViewController: UIViewController {
    
    weak var shopCoordinator: ShopCoordinator?
    
    public let shopView = ShopView()
    public let viewModel = ShopViewModel()
    
    public let racketImages: [String] = [
        Resources.ShopViews.racketFree,
        Resources.ShopViews.racket5000,
        Resources.ShopViews.racket10000,
    ]
    
    public var currentRacketIndex = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupUI()
        setupTargets()
        updateBalanceLabel()
    }
    
    private func setupUI() {
        view.addSubview(shopView)
        
        shopView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func updateBuyTakeButtons() {
        guard let racket = viewModel.getRacket(by: currentRacketIndex + 1) else {
            return
        }
        print(racket)
        if racket.isPurchased == true {
            shopView.buyButton.isHidden = true
            shopView.takeButton.isHidden = false
        } else {
            shopView.buyButton.isHidden = false
            shopView.takeButton.isHidden = true
        }
    }
    
    func updateBalanceLabel() {
        let balance = viewModel.getBalance()
        shopView.balanceLabel.text = "\(balance)"
    }
}
