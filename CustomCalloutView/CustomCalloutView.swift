//
//  CustomCalloutView.swift
//  CustomCalloutView
//
//  Created by Rajat Bhatt on 08/03/18.
//  Copyright © 2018 Eastern Enterprise. All rights reserved.
//

import UIKit

class CustomCalloutView: UIView {
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var topCenterButton: UIButton!
    @IBOutlet weak var leftCenterButton: UIButton!
    @IBOutlet weak var rightBottomButton: UIButton!
    @IBOutlet weak var leftBottomButton: UIButton!
    @IBOutlet weak var rightCenterButton: UIButton!
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.cornerRadius = self.frame.height/2
        self.buttonView.layer.cornerRadius = self.buttonView.frame.size.height/2
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if topCenterButton.frame.contains(point) {
            return topCenterButton
        }
        if leftCenterButton.frame.contains(point) {
            return buttonView.hitTest(point, with:event)
        }
        if rightCenterButton.frame.contains(point) {
            return buttonView.hitTest(point, with:event)
        }
        if leftBottomButton.frame.contains(point) {
            return buttonView.hitTest(point, with:event)
        }
        if rightBottomButton.frame.contains(point) {
            return buttonView.hitTest(point, with:event)
        }
        return super.hitTest(point, with: event)
    }
}
