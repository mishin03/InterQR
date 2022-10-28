//
//  MyCollectionViewCell.swift
//  InterQR
//
//  Created by Илья Мишин on 07.09.2022.
//

import UIKit

class DoorCollectionViewCell: UICollectionViewCell {
    
    static let cellId = String(describing: DoorCollectionViewCell.self)
    
    var spinner = UIActivityIndicatorView(style: .medium)
         
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.myDoors
        label.font = Resources.Fonts.skModernistBold(with: 19)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.description
        label.font = Resources.Fonts.skModernistBold(with: 16)
        
        return label
    }()
    
    private let iconImageVeiw: UIImageView = {
        let image = UIImageView()
        image.image = Resources.Images.iconCellLocked
        image.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 45),
            image.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        return image
    }()
    
    private let iconDoorImageVeiw: UIImageView = {
        let image = UIImageView()
        image.image = Resources.Images.doorIconLocked
        
        return image
    }()
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.locked
        label.textColor = Resources.Colors.locked
        label.font = Resources.Fonts.skModernistBold(with: 17)
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = Resources.Colors.cellBorder.cgColor
        
        configure()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup with doors
    
    func set(door: Door) {
        titleLabel.text = door.title
        descriptionLabel.text = door.location
        switch door.state {
        case .locked:
            iconImageVeiw.image = Resources.Images.iconCellLocked
            stateLabel.text = Resources.Strings.locked
            stateLabel.textColor = Resources.Colors.locked
            iconDoorImageVeiw.image = Resources.Images.doorIconLocked
        case .unlocking:
            iconImageVeiw.image = Resources.Images.waitIcon
            stateLabel.text = Resources.Strings.unlocking
            stateLabel.textColor = Resources.Colors.unlocking
            iconDoorImageVeiw.isHidden = true
            spinner.startAnimating()
        case .unlocked:
            spinner.stopAnimating()
            stateLabel.text = Resources.Strings.unlocked
            stateLabel.textColor = Resources.Colors.unlocked
            iconDoorImageVeiw.isHidden = false
            iconDoorImageVeiw.image = Resources.Images.doorIconUnlocked
            iconImageVeiw.image = Resources.Images.iconCellUnlocked
        }
        door.delegate = self
    }
}

extension DoorCollectionViewCell: DoorDelegate {
    
    //MARK: - Implement Delegate method
    
    func stateChanged(newState: DoorState) {
        switch newState {
        case .locked:
            iconImageVeiw.image = Resources.Images.iconCellLocked
            stateLabel.text = Resources.Strings.locked
            stateLabel.textColor = Resources.Colors.locked
            iconDoorImageVeiw.image = Resources.Images.doorIconLocked
        case .unlocking:
            iconImageVeiw.image = Resources.Images.waitIcon
            stateLabel.text = Resources.Strings.unlocking
            stateLabel.textColor = Resources.Colors.unlocking
            iconDoorImageVeiw.isHidden = true
            spinner.startAnimating()
        case .unlocked:
            spinner.stopAnimating()
            stateLabel.text = Resources.Strings.unlocked
            stateLabel.textColor = Resources.Colors.unlocked
            iconDoorImageVeiw.isHidden = false
            iconDoorImageVeiw.image = Resources.Images.doorIconUnlocked
            iconImageVeiw.image = Resources.Images.iconCellUnlocked
        }
    }
    
    //MARK: - Setup cell
    
    func configure() {
        
        contentView.addSubview(iconImageVeiw)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(iconDoorImageVeiw)
        contentView.addSubview(stateLabel)
        contentView.addSubview(spinner)
        
        iconImageVeiw.snp.makeConstraints { make in
            make.top.equalTo(snp_top).inset(20)
            make.left.equalTo(snp_left).inset(30)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp_top).inset(20)
            make.left.equalTo(iconImageVeiw.snp_right).offset(10)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottom)
            make.left.equalTo(iconImageVeiw.snp_right).offset(10)
        }
        iconDoorImageVeiw.snp.makeConstraints { make in
            make.top.equalTo(snp_top).inset(20)
            make.right.equalTo(snp_right).inset(30)
        }
        spinner.snp.makeConstraints { make in
            make.top.equalTo(snp_top).inset(30)
            make.right.equalTo(snp_right).inset(40)
        }
        stateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp_centerX)
            make.bottom.equalTo(snp_bottom).inset(15)
        }
    }
}
