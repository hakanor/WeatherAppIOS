//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Hakan Or on 13.07.2022.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    var index : Int = 0
    // MARK: - Subviews
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Now"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        var image = UIImage(systemName: "sun.max")
        icon.image = image
        icon.tintColor = .black
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "34°"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        
        contentView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        containerView.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        containerView.addSubview(icon)
        icon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor).isActive = true
        icon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        icon.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        
        containerView.addSubview(degreeLabel)
        degreeLabel.topAnchor.constraint(equalTo: icon.bottomAnchor).isActive = true
        degreeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        degreeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.timeLabel.textColor = .systemGray
        containerView.backgroundColor = .clear
    }
    
    // MARK: - Configuration
    func setCollectionViewCellLabels(timeLabel: String, iconName: String, degreeLabel: String, index: Int){
        self.timeLabel.text = timeLabel
        let url = "https://openweathermap.org/img/wn/\(iconName)@2x.png"
        self.icon.imageFromUrl(from: url)
        self.degreeLabel.text = degreeLabel
        self.index = index
        
        containerView.layer.cornerRadius = 16
        if(index == 0){
            containerView.layer.applySketchShadow()
            self.timeLabel.textColor = .systemBlue
            containerView.backgroundColor = .white
        }
    }
    
}
