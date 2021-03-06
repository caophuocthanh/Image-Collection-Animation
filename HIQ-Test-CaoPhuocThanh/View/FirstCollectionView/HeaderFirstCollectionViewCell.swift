//
//  HeaderFirstCollectionViewCell.swift
//  HIQ-Test-CaoPhuocThanh
//
//  Created by Cao Phuoc Thanh on 10/26/17.
//  Copyright © 2017 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class HeaderFirstCollectionViewCell: CollectionViewCell {
    
    var imageURLString: String! {
        didSet{
            guard let imageURLString = self.imageURLString else { return }
            self.imageView.loadImage(imageURLString) { (success) in
                self.imageView.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    var labelString: String! {
        didSet{
            guard let `labelString` = self.labelString else { return }
            self.labelLabel.text = labelString
        }
    }
    
    fileprivate let imageView: ImageView = ImageView()
    fileprivate let labelLabel: Label = Label()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    @objc func updatelabelTime() {
        self.labelLabel.text = Date.hourNow()
    }
    
    override func loadView() {
        super.loadView()

        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatelabelTime), userInfo: nil, repeats: true)
        
        self.imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 8
        self.contentView.addSubview(self.imageView)
        
        self.labelLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.imageView.addSubviews(self.labelLabel)
        self.labelLabel.text = "--:--"
        self.labelLabel.textColor = UIColor.white
        
    }
    
    override func addContraints() {
        super.addContraints()
        
        self.contentView.visual("H:|-4-[v]-4-|", views: ["v": self.imageView])
        self.contentView.visual("V:|-[v]-36-|", views: ["v": self.imageView])
        
        self.imageView.visual("H:|-[v]-|", views: ["v": labelLabel])
        self.labelLabel.visualAlignV(self.imageView)
    }
}
