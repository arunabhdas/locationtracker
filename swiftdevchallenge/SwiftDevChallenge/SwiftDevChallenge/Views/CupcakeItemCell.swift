//
//  CupcakeItemCell.swift
//  SwiftDevChallenge
//
//  Created by Das on 11/22/19.
//  Copyright © 2019 Arunabh Das. All rights reserved.
//

import UIKit
import Cupcake

class CupcakeItemCell: UITableViewCell {
    var iconView: UIImageView!
    var actionButton: UIButton!
    var indexLabel, titleLabel, title2Label: UILabel!
    var subtitleLabel, subtitle2Label, subtitle3Label: UILabel!
    
    func update(app: Dictionary<String, Any>, index: Int) {
        indexLabel.str(index + 1)
        iconView.img(app["iconName"] as! String)
        titleLabel.text = app["title"] as? String
        title2Label.text = app["category"] as? String
        subtitle2Label.text = Str("(%@)", app["commentCount"] as! NSNumber)
        subtitle3Label.isHidden = !(app["iap"] as! Bool)
        
        let rating = (app["rating"] as! NSNumber).intValue
        var result = ""
        for i in 0..<5 { result = result + (i < rating ? "★" : "☆") }
        subtitleLabel.text = result
        
        let price = app["price"] as! String
        actionButton.str( price.count > 0 ? "$" + price : "GET")
    }
    
    func setupUI() {
        indexLabel = Label.font(17).color("darkGray").align(.right)
        iconView = ImageView.radius(10).border(0.0 / UIScreen.main.scale, "#CCC")
        
        titleLabel = Label.font(17).color("black")
        title2Label = Label.font(17).color("darkGray")
        
        subtitleLabel = Label.font(11).color("orange")
        subtitle2Label = Label.font(11).color("darkGray")
        
        // actionButton = Button.font("15").color(Constants.Colors.colorOptimusOne).border(1, Constants.Colors.colorOptimusTwo).radius(3)
        // actionButton.highColor("white").highBg("darkGray").padding(5, 10)
        
        subtitle3Label = Label.font(15).color("black").lines(2).str("").align(.center)
        
        let ratingStack = HStack(subtitleLabel, subtitle2Label).gap(5)
        let midStack = VStack(titleLabel, title2Label, ratingStack).gap(4)
        let actionStack = VStack(actionButton, subtitle3Label).gap(4).align(.center)
        
        // HStack(indexLabel, iconView, 10, midStack, "<-->", 10, actionStack).embedIn(self.contentView, 10, 0, 10, 15)
        HStack(10, midStack, "<-->", 10, actionStack).embedIn(self.contentView, 10, 0, 10, 15)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

