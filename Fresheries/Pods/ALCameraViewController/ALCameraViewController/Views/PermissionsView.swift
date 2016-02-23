//
//  PermissionsView.swift
//  ALCameraViewController
//
//  Created by Alex Littlejohn on 2015/06/24.
//  Copyright (c) 2015 zero. All rights reserved.
//

import UIKit

internal class PermissionsView: UIView {
   
    let iconView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let settingsButton = UIButton()
    
    let horizontalPadding: CGFloat = 50
    let verticalPadding: CGFloat = 20
    let verticalSpacing: CGFloat = 10
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        
        backgroundColor = UIColor(white: 0.2, alpha: 1)
        
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 22)
        titleLabel.text = LocalizedString("permissions.title")
        
        descriptionLabel.textColor = UIColor.lightGrayColor()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = NSTextAlignment.Center
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        descriptionLabel.text = LocalizedString("permissions.description")
        
        let icon = UIImage(named: "permissionsIcon", inBundle: CameraGlobals.shared.bundle, compatibleWithTraitCollection: nil)!
        iconView.image = icon
        
        settingsButton.contentEdgeInsets = UIEdgeInsetsMake(6, 12, 6, 12)
        settingsButton.setTitle(LocalizedString("permissions.settings"), forState: UIControlState.Normal)
        settingsButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        settingsButton.layer.cornerRadius = 4
        settingsButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        settingsButton.backgroundColor = UIColor(red: 52.0/255.0, green: 183.0/255.0, blue: 250.0/255.0, alpha: 1)
        settingsButton.addTarget(self, action: "openSettings", forControlEvents: UIControlEvents.TouchUpInside)
        
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(settingsButton)
    }
    
    func openSettings() {
        if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.sharedApplication().openURL(appSettings)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maxLabelWidth = frame.width - horizontalPadding * 2
        
        let iconSize = iconView.image!.size
        let constrainedTextSize = CGSize(width: maxLabelWidth, height: CGFloat.max)
        let titleSize = titleLabel.sizeThatFits(constrainedTextSize)
        let descriptionSize = descriptionLabel.sizeThatFits(constrainedTextSize)
        let settingsSize = settingsButton.sizeThatFits(constrainedTextSize)
        
        let iconX = frame.width/2 - iconSize.width/2
        let iconY: CGFloat = frame.height/2 - (iconSize.height + verticalSpacing + verticalSpacing + titleSize.height + verticalSpacing + descriptionSize.height)/2;
        
        iconView.frame = CGRect(x: iconX, y: iconY, width: iconSize.width, height: iconSize.height)
        
        let titleX = frame.width/2 - titleSize.width/2
        let titleY = iconY + iconSize.height + verticalSpacing + verticalSpacing
        
        titleLabel.frame = CGRect(x: titleX, y: titleY, width: titleSize.width, height: titleSize.height)
        
        let descriptionX = frame.width/2 - descriptionSize.width/2
        let descriptionY = titleY + titleSize.height + verticalSpacing
        
        descriptionLabel.frame = CGRect(x: descriptionX, y: descriptionY, width: descriptionSize.width, height: descriptionSize.height)
        
        let settingsX = frame.width/2 - settingsSize.width/2
        let settingsY = descriptionY + descriptionSize.height + verticalSpacing
        
        settingsButton.frame = CGRect(x: settingsX, y: settingsY, width: settingsSize.width, height: settingsSize.height)
    }
}
