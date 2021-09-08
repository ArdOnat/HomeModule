//
//  WeatherInformationUITableViewCell.swift
//  WeatherApp
//
//  Created by Arda Onat on 21.08.2021.
//

import UIKit

class WeatherInformationUITableViewCell: UITableViewCell {

    static let ReuseIdentifier: String = "WeatherInformationUITableViewCell"
    
    // MARK: IBOutlets
    @IBOutlet private weak var dateLabel2: UILabel!
    @IBOutlet private weak var hoursCollectionView2: UICollectionView!
    
    var informationModel: [CountryWeatherInformationModel]? {
        didSet {
            guard let firstInformationModel = informationModel?.first else { return }
            
            dateLabel2.text = "\(firstInformationModel.dt_txt.split(separator: " ").first ?? "")"
            hoursCollectionView2.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hoursCollectionView2.delegate = self
        hoursCollectionView2.dataSource = self
        
        hoursCollectionView2.register(UINib(nibName: HourlyDataCollectionViewCell.ReuseIdentifier, bundle: .module), forCellWithReuseIdentifier: HourlyDataCollectionViewCell.ReuseIdentifier)
    }
}

extension WeatherInformationUITableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.layer.bounds.width / 2.5, height: collectionView.layer.bounds.height)
    }
}

extension WeatherInformationUITableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let informationModel = informationModel else { return 0 }
        return informationModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: HourlyDataCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyDataCollectionViewCell.ReuseIdentifier, for: indexPath) as? HourlyDataCollectionViewCell, let informationModel = informationModel else { return UICollectionViewCell() }
        cell.configure(informationModel: informationModel[indexPath.row])
        return cell
    }
}
