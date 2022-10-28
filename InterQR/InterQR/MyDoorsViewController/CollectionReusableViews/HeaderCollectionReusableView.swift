//
//  HeaderCollectionReusableView.swift
//  InterQR
//
//  Created by Илья Мишин on 09.09.2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableView"
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.welcome
        label.font = Resources.Fonts.skModernistBold(with: 40)
        label.textColor = .black
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    private let homeImage: UIImageView = {
        var image = UIImageView()
        image.image = Resources.Images.home
        image.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        image.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        return image
    }()
    
    private let myDoorsLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.myDoors
        label.font = Resources.Fonts.skModernistBold(with: 20)
        label.textColor = Resources.Colors.myDoors
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .clear
        addSubview(welcomeLabel)
        addSubview(homeImage)
        addSubview(myDoorsLabel)
        
        welcomeLabel.snp.makeConstraints { make in
            make.left.equalTo(snp_left).inset(20)
            make.top.equalTo(snp_top).inset(95)
        }

        homeImage.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(welcomeLabel.snp_right).offset(15)
            make.top.equalTo(snp_top).inset(45)
            make.right.equalTo(snp_right).inset(5)
            make.width.equalTo(homeImage.snp_height).multipliedBy(186/168)
            make.width.greaterThanOrEqualTo(186/4*3)
        }

        myDoorsLabel.snp.makeConstraints { make in
            make.left.equalTo(snp_left).inset(25)
            make.bottom.equalTo(snp_bottom).inset(5)
        }
    }
}
