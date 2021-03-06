//
//  ForecastScrollViewCell.swift
//  WeatherApp
//
//  Created by Hakan Or on 12.07.2022.
//

import UIKit

class ForecastCollectionView : UITableViewCell {
    
    var forecastInfo: ForecastInfoResponseBody?
    
    // MARK: - Subviews
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //    TODO: set labels (dayLabel, degree, feelslike)
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunday"
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "33°"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "34°"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 100)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectioncell")
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        containerView.addSubview(dayLabel)
        dayLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dayLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 5).isActive = true
        
        containerView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor,constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        containerView.addSubview(feelsLikeLabel)
        feelsLikeLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        feelsLikeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -20).isActive = true
        
        containerView.addSubview(degreeLabel)
        degreeLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        degreeLabel.trailingAnchor.constraint(equalTo: feelsLikeLabel.leadingAnchor,constant: -10).isActive = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: ForecastCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    // MARK: - Configuration
    func setForecastCollectionViewLabels(day:String, feelsLike:String, temp:String){
        dayLabel.text = day
        feelsLikeLabel.text = feelsLike
        degreeLabel.text = temp
    }
    
    func setInfoBody(body : ForecastInfoResponseBody?){
        self.forecastInfo = body
        collectionView.reloadData()
    }
        
}

// MARK: - UICollectionView Delegate , DataSource
extension ForecastCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.identifier, for: indexPath) as! ForecastCollectionViewCell
        var timeText = forecastInfo?.list[indexPath.row].dt_txt ?? "-"
        let degreeText = String(forecastInfo?.list[indexPath.row].main.tempC ?? 0) + "°"
        timeText = timeText.timeFormatter(comingDayText: timeText)
        let icon = String(forecastInfo?.list[(indexPath.row)].weather.first?.icon ?? "sun.max")
        
        cell.setCollectionViewCellLabels(
            timeLabel: timeText,
            iconName: icon,
            degreeLabel: degreeText,
            index: indexPath.row
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
}
