
import Foundation
import UIKit

class LevelCell: UICollectionViewCell {
    
    static let reuseId = "LevelCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
