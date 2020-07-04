/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
import UIKit


enum Section {
  case main
}


enum Format {
  case compact
  case large
}


class DataManager {
  
  typealias PokemonDataSource = UICollectionViewDiffableDataSource<Section, Pokemon>
  typealias PokemonSnapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>

  
  private static func configureDataSource(for collectionView: UICollectionView, format: Format) -> PokemonDataSource {

    let dataSource = UICollectionViewDiffableDataSource<Section, Pokemon>(collectionView: collectionView) { (collectionView, indexPath, pokemon) -> UICollectionViewCell? in
      
      #warning("Make a switch to alternate between cells.")
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompactPokemonCollectionViewCell.reuseIdentifier, for: indexPath) as? CompactPokemonCollectionViewCell else { return nil }
      
      cell.populate(with: pokemon)
      return cell
    }
    
    return dataSource
  }
  
  
  private static func configureSnapshot(of pokemons: [Pokemon], with dataSource: PokemonDataSource) -> PokemonSnapshot {
    var currentSnapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
    currentSnapshot.appendSections([.main])
    currentSnapshot.appendItems(pokemons)
    
    return currentSnapshot
  }
  
  
  static func configure(with pokemons: [Pokemon], in collectionView: UICollectionView, format: Format) -> PokemonDataSource {
    var dataSource: UICollectionViewDiffableDataSource<Section, Pokemon>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, Pokemon>!
    
    dataSource = configureDataSource(for: collectionView, format: format)
    snapshot = configureSnapshot(of: pokemons, with: dataSource)
    dataSource.apply(snapshot, animatingDifferences: true)
    
    return dataSource
  }
  
}
