//
//  ViewController.swift
//  InterQR
//
//  Created by Илья Мишин on 04.09.2022.
//

import UIKit
import SnapKit

class MyDoorsViewController: UIViewController {
    
    var collectionView: UICollectionView?
    
    var doors: [Door] = []
    
    var spinner = UIActivityIndicatorView(style: .medium)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width / 1.1,
                                 height: 130)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.backgroundColor = .white
        
        collectionView?.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        collectionView?.register(DoorCollectionViewCell.self,
                                 forCellWithReuseIdentifier: DoorCollectionViewCell.cellId)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        view.addSubview(collectionView!)
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.equalTo(collectionView!.snp_centerX)
            make.centerY.equalTo(collectionView!.snp_centerY)
        }
        
        layoutSubview()
        setupNavBar()
        getDoors()
    }
    
    func getDoors() {
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
            guard let self = self else { return }
            self.spinner.stopAnimating()
            let doorsAmount = Int.random(in: 5...6)
            let locations = ["Home", "Office", "Garage"]
            self.doors = Array(0...doorsAmount).map({ id in
                let title = "Door \(id + 1)"
                let location = "\(locations.randomElement()!)"
                return Door(id: id, title: title, location: location, state: .locked)
            })
            self.collectionView?.reloadData()
        })
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MyDoorsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoorCollectionViewCell.cellId,
                                                      for: indexPath) as! DoorCollectionViewCell
        
        guard doors.count > indexPath.row else { return cell }
        let door = doors[indexPath.row]
        cell.set(door: door)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let door = doors[indexPath.row]
        door.state = .unlocking
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { timer in
            if door.state == .unlocking {
                door.state = .unlocked
            }
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
                if door.state == .unlocked {
                    door.state = .locked
                }
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 240)
    }
}

// MARK: - Private -
// MARK: - Setup UI -

extension MyDoorsViewController {
    func layoutSubview() {
        collectionView?.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        })
    }
    
    func setupNavBar() {
        
        let interLabel = UILabel()
        interLabel.font = Resources.Fonts.skModernistBold(with: 24)
        interLabel.textColor = Resources.Colors.inter
        
        let fullString = NSMutableAttributedString(string: "Inter")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "QR")
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        fullString.append(imageString)
        interLabel.attributedText = fullString

        let settingsButton: UIButton = {
            let button = UIButton()
            button.setImage(Resources.Images.settingsButton, for: .normal)
            button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)

            return button
        }()

        let titleView = UIView()
        titleView.backgroundColor = .white
        titleView.layer.shadowOpacity = 0.5
        
        view.addSubview(titleView)
        titleView.addSubview(interLabel)
        titleView.addSubview(settingsButton)
                
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.snp_top)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }

        interLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(titleView.snp_bottom).inset(12)
            make.left.equalTo(titleView).inset(10)
        }
        settingsButton.snp.makeConstraints { make in
            make.right.equalTo(titleView.snp_right).inset(10)
            make.centerY.equalTo(interLabel)
        }
        
    }
    @objc func pressButton() {
        let alert = UIAlertController(title: "Ooops", message: "This button is currently not functional", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
