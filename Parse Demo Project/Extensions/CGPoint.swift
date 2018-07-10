//
//  CGPoint.swift
//  SUB Chat
//
//  Created by Marius Ilie on 28/03/17.
//  Copyright © 2017 Marius Ilie. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    func distance(to b: CGPoint) -> CGFloat {
        let xDist = self.x - b.x
        let yDist = self.y - b.y
        
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
}
