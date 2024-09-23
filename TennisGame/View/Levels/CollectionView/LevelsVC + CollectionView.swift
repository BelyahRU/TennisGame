
import Foundation
import UIKit

extension LevelsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func setupCollectionView() {
        levelsView.levelsCollectionView.dataSource = self
        levelsView.levelsCollectionView.delegate = self
        levelsView.levelsCollectionView.register(LevelCell.self, forCellWithReuseIdentifier: LevelCell.reuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCell.reuseId, for: indexPath) as? LevelCell else {
                    return UICollectionViewCell()
                }
        guard let level = viewModel.getLevel(by: indexPath.row + 1) else {
            return UICollectionViewCell()
        }

        cell.setupCell(level: level)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        
        let numberOfColumns: CGFloat = 3
        
        let spacing: CGFloat = 16 / 430 * levelsView.bounds.width
        let totalSpacing = spacing * (numberOfColumns - 1)
        let availableWidth = screenWidth - totalSpacing
        let itemWidth = availableWidth / numberOfColumns
        
        let itemHeight = itemWidth * (148 / 99)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        levelsCoordinator.showGame(with: indexPath.row + 1)
    }
}
